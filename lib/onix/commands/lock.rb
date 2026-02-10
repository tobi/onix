# frozen_string_literal: true

require "scint/lockfile/parser"
require "scint/materializer"
require "scint/credentials"
require "digest"
require "open3"
require "json"
require "net/http"
require "uri"
require "fileutils"

module Onix
  module Commands
    # `onix lock` — read a Gemfile.lock and produce a gems.lock.nix with sha256 hashes.
    # This replaces fetch+generate: nix itself will fetch the gems.
    class Lock
      def run(argv)
        @project = Project.new
        name_override = nil
        jobs = 20

        while argv.first&.start_with?("-")
          case argv.shift
          when "--name", "-n" then name_override = argv.shift
          when "-j", "--jobs" then jobs = argv.shift.to_i
          when "--help", "-h"
            $stderr.puts "Usage: onix lock [options] <path>"
            $stderr.puts "  --name, -n NAME   Override project name"
            $stderr.puts "  -j, --jobs N      Parallel hash jobs (default: 20)"
            exit 0
          end
        end

        if argv.empty?
          $stderr.puts "Usage: onix lock <path/to/Gemfile.lock>"
          exit 1
        end

        lockfile, project_name = resolve_lockfile(argv.first, name_override)

        UI.header "Lock #{UI.bold(project_name)}"
        UI.info lockfile

        lockdata = Scint::Lockfile::Parser.parse(lockfile)
        credentials = Scint::Credentials.new
        credentials.register_lockfile_sources(lockdata.sources)

        mat = Scint::Materializer.new(cache_dir: @project.cache_dir)
        classified = mat.classify(lockdata)

        rubygems = classified[:rubygems]
        git_repos = classified[:git]
        git_gems = git_repos.values.flat_map { |r| r[:gems].map { |g| g.merge(repo: r) } }

        UI.info "#{rubygems.size} rubygems, #{git_gems.size} git gems"

        # Compute sha256 hashes for all gems
        entries = {}

        # Rubygems: prefetch to get sha256
        if rubygems.any?
          progress = UI::Progress.new(rubygems.size, label: "Hashing rubygems")
          rubygems.each do |gem|
            name = gem[:name]
            version = gem[:version]
            platform = gem[:platform]
            source_uri = gem[:source_uri] || "https://rubygems.org/"

            slug = platform && platform != "ruby" ? "#{name}-#{version}-#{platform}" : "#{name}-#{version}"
            url = "#{source_uri.chomp("/")}/gems/#{slug}.gem"

            sha256 = nix_prefetch_url(url, credentials)
            unless sha256
              progress.finish
              UI.fail "Failed to hash #{name} #{version} from #{url}"
              exit 1
            end

            entries[name] = {
              version: version,
              source: {
                type: "gem",
                remotes: [source_uri.chomp("/")],
                sha256: sha256,
              },
            }
            progress.advance
          end
          progress.finish
        end

        # Git repos: prefetch to get sha256
        if git_repos.any?
          progress = UI::Progress.new(git_repos.size, label: "Hashing git repos")
          git_repos.each_value do |repo|
            sha256 = nix_prefetch_git(repo[:uri], repo[:rev])
            unless sha256
              progress.finish
              UI.fail "Failed to hash git repo #{repo[:uri]} @ #{repo[:rev]}"
              exit 1
            end

            repo[:gems].each do |g|
              entries[g[:name]] = {
                version: g[:version],
                source: {
                  type: "git",
                  url: repo[:uri],
                  rev: repo[:rev],
                  sha256: sha256,
                  fetchSubmodules: repo[:submodules] || false,
                },
              }
            end
            progress.advance
          end
          progress.finish
        end

        # Write gems.lock.nix
        write_lock_nix(project_name, entries)
        write_default_nix(project_name)

        UI.done "#{entries.size} gems locked"
      end

      private

      def resolve_lockfile(arg, name_override)
        path = File.expand_path(arg)
        if File.directory?(path)
          lockfile = File.join(path, "Gemfile.lock")
          abort "No Gemfile.lock in #{path}" unless File.exist?(lockfile)
        elsif File.exist?(path)
          lockfile = path
        else
          abort "Not found: #{arg}"
        end
        project = name_override || File.basename(File.dirname(lockfile))
        [lockfile, project]
      end

      def nix_prefetch_url(url, credentials)
        # Use nix-prefetch-url to get the sha256
        out, status = Open3.capture2("nix-prefetch-url", "--type", "sha256", url)
        return out.strip if status.success?
        nil
      end

      def nix_prefetch_git(url, rev)
        out, status = Open3.capture2("nix-prefetch-git", "--url", url, "--rev", rev, "--quiet")
        return nil unless status.success?
        data = JSON.parse(out)
        data["sha256"]
      rescue
        nil
      end

      def write_lock_nix(project_name, entries)
        nix = +"# gems.lock.nix — generated by onix lock. Do not edit.\n"
        nix << "# #{project_name}: #{entries.size} gems\n"
        nix << "{\n"

        entries.sort_by { |name, _| name }.each do |name, entry|
          nix << "  #{nix_key(name)} = {\n"
          nix << "    version = #{entry[:version].inspect};\n"

          src = entry[:source]
          if src[:type] == "gem"
            nix << "    source = {\n"
            nix << "      type = \"gem\";\n"
            nix << "      remotes = [ #{src[:remotes].map(&:inspect).join(" ")} ];\n"
            nix << "      sha256 = #{src[:sha256].inspect};\n"
            nix << "    };\n"
          elsif src[:type] == "git"
            nix << "    source = {\n"
            nix << "      type = \"git\";\n"
            nix << "      url = #{src[:url].inspect};\n"
            nix << "      rev = #{src[:rev].inspect};\n"
            nix << "      sha256 = #{src[:sha256].inspect};\n"
            nix << "      fetchSubmodules = #{src[:fetchSubmodules]};\n"
            nix << "    };\n"
          end

          nix << "  };\n"
        end

        nix << "}\n"

        dir = File.join(@project.root, "nix")
        FileUtils.mkdir_p(dir)
        path = File.join(dir, "#{project_name}.lock.nix")
        File.write(path, nix)
        UI.wrote "nix/#{project_name}.lock.nix"
      end

      def write_default_nix(project_name)
        nix = <<~'NIX'
          # %{project} — generated by onix lock. Do not edit.
          { pkgs ? import <nixpkgs> {}, ruby ? pkgs.ruby_3_4 }:
          let
            buildGem = import ./build-gem.nix { inherit pkgs ruby; };
            gemConfig = import ./gem-config.nix {
              inherit pkgs ruby;
              overlayDir = ../overlays;
            };
            gems = import ./%{project}.lock.nix;

            buildAll = builtins.mapAttrs (name: spec:
              let
                config = gemConfig.${name} or {};
              in buildGem (spec // {
                gemName = name;
                nativeBuildInputs = config.deps or [];
                extconfFlags = config.extconfFlags or "";
                beforeBuild = config.beforeBuild or "";
                afterBuild = config.afterBuild or "";
              } // (if config ? buildPhase then { inherit (config) buildPhase; } else {})
                // (if config ? postInstall then { inherit (config) postInstall; } else {})
                // (if config ? skip then { inherit (config) skip; } else {}))
            ) gems;

            bundlePath = pkgs.buildEnv {
              name = "%{project}-bundle";
              paths = builtins.attrValues buildAll;
            };
          in buildAll // {
            inherit bundlePath;
            devShell = { buildInputs ? [], shellHook ? "", ... }@args:
              pkgs.mkShell (builtins.removeAttrs args ["buildInputs" "shellHook"] // {
                name = "%{project}-devshell";
                buildInputs = [ ruby ] ++ buildInputs;
                shellHook = ''
                  export BUNDLE_PATH="${bundlePath}"
                  export BUNDLE_GEMFILE="''${BUNDLE_GEMFILE:-$PWD/Gemfile}"
                '' + shellHook;
              });
          }
        NIX

        nix = nix.gsub("%{project}", project_name)

        dir = File.join(@project.root, "nix")
        FileUtils.mkdir_p(dir)
        path = File.join(dir, "#{project_name}.nix")
        File.write(path, nix)
        UI.wrote "nix/#{project_name}.nix"

        # Copy build-gem.nix and gem-config.nix into nix/
        data_dir = File.expand_path("../data", __dir__)
        %w[build-gem.nix gem-config.nix].each do |f|
          src = File.join(data_dir, f)
          dest = File.join(dir, f)
          FileUtils.cp(src, dest)
          UI.wrote "nix/#{f}"
        end
      end

      def nix_key(name)
        # Nix attribute names with dashes need quoting
        name =~ /^[a-zA-Z_][a-zA-Z0-9_]*$/ ? name : "\"#{name}\""
      end
    end
  end
end
