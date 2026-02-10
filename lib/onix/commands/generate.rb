# frozen_string_literal: true

require "scint/lockfile/parser"
require "scint/materializer"
require "scint/credentials"
require "open3"
require "json"
require "fileutils"
require "set"
require "thread"

module Onix
  module Commands
    # `onix generate` — reads packagesets, prefetches hashes, writes nix files.
    #
    # Output:
    #   nix/ruby/<name>.nix      — per-gem: all known versions + sha256 hashes
    #   nix/<project>.nix        — per-project: selects gem versions
    #   nix/build-gem.nix        — generic builder
    #   nix/gem-config.nix       — overlay loader
    #
    class Generate
      def run(argv)
        @project = Project.new
        jobs = (ENV["JOBS"] || "20").to_i

        while argv.first&.start_with?("-")
          case argv.shift
          when "-j", "--jobs" then jobs = argv.shift.to_i
          when "--help", "-h"
            $stderr.puts "Usage: onix generate [options]"
            $stderr.puts "  -j, --jobs N    Parallel prefetch jobs (default: 20)"
            exit 0
          end
        end

        packagesets = Dir.glob(File.join(@project.packagesets_dir, "*.gem"))
        if packagesets.empty?
          UI.fail "No packagesets found. Run 'onix import' first."
          exit 1
        end

        UI.header "Generate"

        credentials = Scint::Credentials.new
        mat = Scint::Materializer.new(cache_dir: @project.cache_dir)

        # ── Collect all gems across all projects ─────────────────────

        all_gems = {}      # "name/version" => { name:, version:, source_uri:, platform: }
        all_git = {}       # "base-shortrev" => repo hash
        projects = {}      # project_name => classified

        packagesets.each do |f|
          project_name = File.basename(f, ".gem")
          lockdata = @project.parse_lockfile(f)
          credentials.register_lockfile_sources(lockdata.sources)
          classified = mat.classify(lockdata)

          classified[:rubygems].each do |g|
            key = "#{g[:name]}/#{g[:version]}"
            all_gems[key] ||= g
          end
          classified[:git].each do |key, repo|
            all_git[key] ||= repo
          end

          projects[project_name] = classified
        end

        rubygem_count = all_gems.size
        git_gem_count = all_git.values.sum { |r| r[:gems].size }
        UI.info "#{packagesets.size} packagesets, #{rubygem_count + git_gem_count} unique gems"

        # ── Load existing hashes to skip re-prefetch ─────────────────

        ruby_dir = File.join(@project.root, "nix", "ruby")
        existing = load_existing_hashes(ruby_dir)
        UI.info "#{existing.size} existing hashes" if existing.any?

        # ── Prefetch rubygems ────────────────────────────────────────

        new_hashes = {}
        if all_gems.any?
          needed = all_gems.values.reject { |g| existing.key?("#{g[:name]}/#{g[:version]}") }
          cached = all_gems.size - needed.size

          if needed.empty?
            UI.done "#{all_gems.size} rubygems (all hashes cached)"
          else
            progress = UI::Progress.new(all_gems.size, label: "Prefetch")
            cached.times { progress.advance(skip: true) }
            errors = prefetch_parallel(needed, jobs, new_hashes, progress)
            progress.finish

            if errors.any?
              errors.each { |e| UI.fail e }
              exit 1
            end
          end
        end

        # ── Prefetch git repos ───────────────────────────────────────

        if all_git.any?
          progress = UI::Progress.new(all_git.size, label: "Prefetch git")
          all_git.each_value do |repo|
            repo_key = "git:#{repo[:uri]}@#{repo[:rev]}"
            sha256 = existing[repo_key]
            unless sha256
              sha256 = nix_prefetch_git(repo[:uri], repo[:rev])
              unless sha256
                progress.finish
                UI.fail "Failed to prefetch #{repo[:uri]} @ #{repo[:rev]}"
                exit 1
              end
            end
            repo[:sha256] = sha256
            progress.advance
          end
          progress.finish
        end

        # ── Write nix/ruby/<name>.nix per gem ────────────────────────

        nix_dir = File.join(@project.root, "nix")
        FileUtils.mkdir_p(ruby_dir)

        # Group by gem name
        by_name = {}
        all_gems.each_value do |g|
          (by_name[g[:name]] ||= []) << {
            version: g[:version],
            sha256: existing["#{g[:name]}/#{g[:version]}"] || new_hashes["#{g[:name]}/#{g[:version]}"],
            source_uri: g[:source_uri]&.chomp("/") || "https://rubygems.org",
          }
        end
        all_git.each_value do |repo|
          repo[:gems].each do |g|
            (by_name[g[:name]] ||= []) << {
              version: g[:version],
              sha256: repo[:sha256],
              git: { url: repo[:uri], rev: repo[:rev], fetchSubmodules: repo[:submodules] || false },
            }
          end
        end

        by_name.each { |name, versions| write_gem_nix(ruby_dir, name, versions) }
        UI.wrote "nix/ruby/ (#{by_name.size} gems)"

        # ── Write per-project nix ────────────────────────────────────

        projects.each { |name, classified| write_project_nix(nix_dir, name, classified) }

        # ── Copy support files ───────────────────────────────────────

        copy_support_files(nix_dir)

        UI.done "#{by_name.size} gems, #{projects.size} projects"
      end

      private

      # ── Existing hash loader ─────────────────────────────────────

      def load_existing_hashes(ruby_dir)
        hashes = {}
        return hashes unless Dir.exist?(ruby_dir)

        Dir.glob(File.join(ruby_dir, "*.nix")).each do |f|
          name = File.basename(f, ".nix")
          content = File.read(f)
          content.scan(/"([^"]+)"\s*=\s*\{[^}]*sha256\s*=\s*"([^"]+)"/) do |version, sha256|
            hashes["#{name}/#{version}"] = sha256
          end
        end
        hashes
      end

      # ── Parallel prefetch ──────────────────────────────────────

      def prefetch_parallel(gems, jobs, hashes, progress)
        errors = []
        mutex = Mutex.new
        queue = Queue.new
        gems.each { |g| queue << g }
        jobs.times { queue << nil }

        threads = jobs.times.map do
          Thread.new do
            while (g = queue.pop)
              name = g[:name]
              version = g[:version]
              platform = g[:platform]
              source_uri = g[:source_uri] || "https://rubygems.org/"

              slug = platform && platform != "ruby" ? "#{name}-#{version}-#{platform}" : "#{name}-#{version}"
              url = "#{source_uri.chomp("/")}/gems/#{slug}.gem"

              sha256 = nix_prefetch_url(url)
              key = "#{name}/#{version}"

              mutex.synchronize do
                if sha256
                  hashes[key] = sha256
                  progress.advance
                else
                  errors << "Failed to prefetch #{name} #{version} from #{url}"
                  progress.advance(success: false)
                end
              end
            end
          end
        end
        threads.each(&:join)
        errors
      end

      def nix_prefetch_url(url)
        out, status = Open3.capture2("nix-prefetch-url", "--type", "sha256", url,
                                     err: File::NULL)
        status.success? ? out.strip : nil
      end

      def nix_prefetch_git(url, rev)
        out, status = Open3.capture2("nix-prefetch-git", "--url", url, "--rev", rev,
                                     "--quiet", err: File::NULL)
        return nil unless status.success?
        JSON.parse(out)["sha256"]
      rescue
        nil
      end

      # ── Writers ────────────────────────────────────────────────

      def write_gem_nix(dir, name, versions)
        nix = +"# #{name} — all known versions. Generated by onix generate.\n"
        nix << "{\n"

        versions.sort_by { |v| Gem::Version.new(v[:version]) rescue Gem::Version.new("0") }.each do |v|
          nix << "  #{nix_str v[:version]} = {\n"
          nix << "    version = #{nix_str v[:version]};\n"
          nix << "    source = {\n"

          if v[:git]
            nix << "      type = \"git\";\n"
            nix << "      url = #{nix_str v[:git][:url]};\n"
            nix << "      rev = #{nix_str v[:git][:rev]};\n"
            nix << "      sha256 = #{nix_str v[:sha256]};\n"
            nix << "      fetchSubmodules = #{v[:git][:fetchSubmodules]};\n"
          else
            nix << "      type = \"gem\";\n"
            nix << "      remotes = [ #{nix_str v[:source_uri]} ];\n"
            nix << "      sha256 = #{nix_str v[:sha256]};\n"
          end

          nix << "    };\n"
          nix << "  };\n"
        end

        nix << "}\n"
        File.write(File.join(dir, "#{name}.nix"), nix)
      end

      def write_project_nix(dir, project_name, classified)
        gems = classified[:rubygems].map { |g| { name: g[:name], version: g[:version] } }
        classified[:git].each_value do |repo|
          repo[:gems].each { |g| gems << { name: g[:name], version: g[:version] } }
        end

        nix = +"# #{project_name} — generated by onix generate. Do not edit.\n"
        nix << "{ pkgs ? import <nixpkgs> {}, ruby ? pkgs.ruby_3_4 }:\n"
        nix << "let\n"
        nix << "  buildGem = import ./build-gem.nix { inherit pkgs ruby; };\n"
        nix << "  gemConfig = import ./gem-config.nix { inherit pkgs ruby; overlayDir = ../overlays; };\n"
        nix << "\n"
        nix << "  build = name: version:\n"
        nix << "    let\n"
        nix << "      versions = import (./ruby + \"/\${name}.nix\");\n"
        nix << "      spec = versions.${version};\n"
        nix << "      config = gemConfig.${name} or {};\n"
        nix << "    in buildGem (spec // {\n"
        nix << "      gemName = name;\n"
        nix << "      nativeBuildInputs = config.deps or [];\n"
        nix << "      extconfFlags = config.extconfFlags or \"\";\n"
        nix << "      beforeBuild = config.beforeBuild or \"\";\n"
        nix << "      afterBuild = config.afterBuild or \"\";\n"
        nix << "    } // (if config ? buildPhase then { inherit (config) buildPhase; } else {})\n"
        nix << "      // (if config ? postInstall then { inherit (config) postInstall; } else {})\n"
        nix << "      // (if config ? skip then { inherit (config) skip; } else {}));\n"
        nix << "\n"
        nix << "  gems = {\n"
        gems.sort_by { |g| g[:name] }.each do |g|
          nix << "    #{nix_key(g[:name])} = build #{nix_str g[:name]} #{nix_str g[:version]};\n"
        end
        nix << "  };\n"
        nix << "\n"
        nix << "  bundlePath = pkgs.buildEnv {\n"
        nix << "    name = #{nix_str "#{project_name}-bundle"};\n"
        nix << "    paths = builtins.attrValues gems;\n"
        nix << "  };\n"
        nix << "in gems // {\n"
        nix << "  inherit bundlePath;\n"
        nix << "  devShell = { buildInputs ? [], shellHook ? \"\", ... }@args:\n"
        nix << "    pkgs.mkShell (builtins.removeAttrs args [\"buildInputs\" \"shellHook\"] // {\n"
        nix << "      name = #{nix_str "#{project_name}-devshell"};\n"
        nix << "      buildInputs = [ ruby ] ++ buildInputs;\n"
        nix << "      shellHook = ''\n"
        nix << "        export BUNDLE_PATH=\"${bundlePath}\"\n"
        nix << "        export BUNDLE_GEMFILE=\"''${BUNDLE_GEMFILE:-$PWD/Gemfile}\"\n"
        nix << "      '' + shellHook;\n"
        nix << "    });\n"
        nix << "}\n"

        File.write(File.join(dir, "#{project_name}.nix"), nix)
        UI.wrote "nix/#{project_name}.nix"
      end

      def copy_support_files(dir)
        data_dir = File.expand_path("../data", __dir__)
        %w[build-gem.nix gem-config.nix].each do |f|
          FileUtils.cp(File.join(data_dir, f), File.join(dir, f))
        end
        UI.wrote "nix/build-gem.nix, nix/gem-config.nix"
      end

      def nix_key(name)
        name =~ /^[a-zA-Z_][a-zA-Z0-9_]*$/ ? name : "\"#{name}\""
      end

      def nix_str(s)
        "\"#{s}\""
      end
    end
  end
end
