# frozen_string_literal: true

require "open3"
require "json"
require "fileutils"
require "thread"
require_relative "../packageset"

module Onix
  module Commands
    # `onix generate` — reads JSONL packagesets, prefetches hashes, writes nix.
    #
    # Output:
    #   nix/ruby/<name>.nix   — per-gem: all known versions + sha256 hashes
    #   nix/<project>.nix     — per-project: selects gem versions
    #   nix/build-gem.nix     — generic builder
    #   nix/gem-config.nix    — overlay loader
    #
    class Generate
      def run(argv)
        @project = Project.new
        jobs = (ENV["JOBS"] || "20").to_i

        while argv.first&.start_with?("-")
          case argv.shift
          when "-j", "--jobs" then jobs = argv.shift.to_i
          when "--help", "-h"
            $stderr.puts "Usage: onix generate [-j JOBS]"
            exit 0
          end
        end

        packagesets = Dir.glob(File.join(@project.packagesets_dir, "*.jsonl"))
        if packagesets.empty?
          UI.fail "No packagesets found. Run 'onix import' first."
          exit 1
        end

        UI.header "Generate"

        # ── Load all packagesets ─────────────────────────────────────

        all_entries = {}   # "name/version" => Entry
        projects = {}      # project_name => [Entry, ...]
        all_meta = {}      # project_name => Meta

        packagesets.each do |f|
          project_name = File.basename(f, ".jsonl")
          meta, entries = Packageset.read(f)
          all_meta[project_name] = meta
          projects[project_name] = entries

          entries.each do |e|
            next if e.source == "stdlib" || e.source == "path"
            key = "#{e.name}/#{e.version}"
            all_entries[key] ||= e
          end
        end

        rubygem_entries = all_entries.values.select { |e| e.source == "rubygems" }
        git_entries = all_entries.values.select { |e| e.source == "git" }
        UI.info "#{packagesets.size} packagesets, #{all_entries.size} unique gems " \
                "(#{rubygem_entries.size} rubygems, #{git_entries.size} git)"

        # ── Load existing hashes ─────────────────────────────────────

        ruby_dir = File.join(@project.root, "nix", "ruby")
        existing = load_existing_hashes(ruby_dir)
        UI.info "#{existing.size} cached hashes" if existing.any?

        # ── Prefetch rubygems ────────────────────────────────────────

        new_hashes = {}
        if rubygem_entries.any?
          needed = rubygem_entries.reject { |e| existing.key?("#{e.name}/#{e.version}") }
          cached = rubygem_entries.size - needed.size

          if needed.empty?
            UI.done "#{rubygem_entries.size} rubygems (all cached)"
          else
            progress = UI::Progress.new(rubygem_entries.size, label: "Prefetch")
            cached.times { progress.advance(skip: true) }
            errors = prefetch_rubygems(needed, jobs, new_hashes, progress)
            progress.finish
            if errors.any?
              errors.each { |e| UI.fail e }
              exit 1
            end
          end
        end

        # ── Prefetch git repos ───────────────────────────────────────

        git_repos = {}
        git_entries.each do |e|
          key = "#{e.uri}@#{e.rev}"
          git_repos[key] ||= { uri: e.uri, rev: e.rev, gems: [] }
          git_repos[key][:gems] << e
        end

        if git_repos.any?
          progress = UI::Progress.new(git_repos.size, label: "Prefetch git")
          git_repos.each_value do |repo|
            cache_key = "git:#{repo[:uri]}@#{repo[:rev]}"
            sha256 = existing[cache_key]
            unless sha256
              sha256 = nix_prefetch_git(repo[:uri], repo[:rev])
              unless sha256
                progress.finish
                UI.fail "Failed to prefetch #{repo[:uri]} @ #{repo[:rev]}"
                exit 1
              end
              new_hashes[cache_key] = sha256
            end
            repo[:sha256] = sha256 || existing[cache_key]
            progress.advance
          end
          progress.finish
        end

        # ── Build sha256 lookup ──────────────────────────────────────

        sha256_for = {}

        rubygem_entries.each do |e|
          key = "#{e.name}/#{e.version}"
          sha256_for[key] = existing[key] || new_hashes[key]
        end

        git_repos.each_value do |repo|
          repo[:gems].each do |e|
            key = "#{e.name}/#{e.version}"
            sha256_for[key] = repo[:sha256]
          end
        end

        # ── Write nix/ruby/<name>.nix per gem ────────────────────────

        nix_dir = File.join(@project.root, "nix")
        FileUtils.mkdir_p(ruby_dir)

        by_name = {}
        all_entries.each_value do |e|
          (by_name[e.name] ||= []) << e
        end

        by_name.each do |name, entries|
          write_gem_nix(ruby_dir, name, entries, sha256_for)
        end
        UI.wrote "nix/ruby/ (#{by_name.size} gems)"

        # ── Write per-project nix ────────────────────────────────────

        projects.each do |name, entries|
          write_project_nix(nix_dir, name, entries, all_meta[name])
        end

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
          # Match version blocks with sha256
          content.scan(/"([^"]+)"\s*=\s*\{[^}]*sha256\s*=\s*"([^"]+)"/) do |version, sha256|
            hashes["#{name}/#{version}"] = sha256
          end
          # Match git blocks
          content.scan(/url\s*=\s*"([^"]+)";\s*rev\s*=\s*"([^"]+)";\s*sha256\s*=\s*"([^"]+)"/) do |url, rev, sha256|
            hashes["git:#{url}@#{rev}"] = sha256
          end
        end
        hashes
      end

      # ── Parallel prefetch ──────────────────────────────────────

      def prefetch_rubygems(gems, jobs, hashes, progress)
        errors = []
        mutex = Mutex.new
        queue = Queue.new
        gems.each { |g| queue << g }
        jobs.times { queue << nil }

        threads = jobs.times.map do
          Thread.new do
            while (e = queue.pop)
              url = "#{e.remote}/gems/#{e.name}-#{e.version}.gem"
              sha256 = nix_prefetch_url(url)
              key = "#{e.name}/#{e.version}"

              mutex.synchronize do
                if sha256
                  hashes[key] = sha256
                  progress.advance
                else
                  errors << "#{e.name} #{e.version}: failed to prefetch from #{url}"
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

      def write_gem_nix(dir, name, entries, sha256_for)
        nix = +"# #{name} — generated by onix. Do not edit.\n{\n"

        entries.sort_by { |e| Gem::Version.new(e.version) rescue Gem::Version.new("0") }.each do |e|
          sha256 = sha256_for["#{e.name}/#{e.version}"]
          nix << "  #{nix_str e.version} = {\n"
          nix << "    version = #{nix_str e.version};\n"

          if e.source == "git"
            nix << "    source = {\n"
            nix << "      type = \"git\";\n"
            nix << "      url = #{nix_str e.uri};\n"
            nix << "      rev = #{nix_str e.rev};\n"
            nix << "      sha256 = #{nix_str sha256};\n"
            nix << "      fetchSubmodules = #{e.submodules ? "true" : "false"};\n"
            nix << "    };\n"
            nix << "    subdir = #{nix_str e.subdir};\n" if e.subdir && e.subdir != "."
          else
            nix << "    source = {\n"
            nix << "      type = \"gem\";\n"
            nix << "      remotes = [ #{nix_str e.remote} ];\n"
            nix << "      sha256 = #{nix_str sha256};\n"
            nix << "    };\n"
          end

          if e.require_paths && e.require_paths != ["lib"]
            nix << "    requirePaths = [ #{e.require_paths.map { |p| nix_str(p) }.join(" ")} ];\n"
          end
          if e.executables && !e.executables.empty?
            nix << "    executables = [ #{e.executables.map { |x| nix_str(x) }.join(" ")} ];\n"
          end

          nix << "  };\n"
        end

        nix << "}\n"
        File.write(File.join(dir, "#{name}.nix"), nix)
      end

      def write_project_nix(dir, project_name, entries, meta)
        buildable = entries.reject { |e| e.source == "stdlib" || e.source == "path" }

        nix = +"# #{project_name} — generated by onix. Do not edit.\n"
        nix << "{ pkgs ? import <nixpkgs> {}, ruby ? pkgs.ruby_3_4 }:\n"
        nix << "let\n"
        nix << "  buildGem = import ./build-gem.nix { inherit pkgs ruby; };\n"
        nix << "  gemConfig = import ./gem-config.nix { inherit pkgs ruby; overlayDir = ../overlays; };\n"
        nix << "\n"
        nix << "  build = name: version:\n"
        nix << "    let\n"
        nix << "      versions = import (./ruby + \"/\${name}.nix\");\n"
        nix << "      spec = versions.\${version};\n"
        nix << "      config = gemConfig.\${name} or {};\n"
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
        buildable.sort_by(&:name).each do |e|
          nix << "    #{nix_key(e.name)} = build #{nix_str e.name} #{nix_str e.version};\n"
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
