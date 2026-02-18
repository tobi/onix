# frozen_string_literal: true

require "scint/lockfile/parser"
require "scint/credentials"
require "open3"
require "fileutils"
require "json"
require "set"
require "tmpdir"
require_relative "../pnpm/lockfile"
require_relative "../pnpm/project_config"
require_relative "../packageset"

module Onix
  module Commands
    # `onix import` — parse Gemfile.lock and produce a hermetic JSONL packageset.
    #
    # This is the only step that talks to the outside world (cloning git repos
    # to discover subdirectories). Everything after this is mechanical.
    #
    class Import
      def run(argv)
        @project = Project.new
        name_override = nil
        installer_override = nil

        while argv.first&.start_with?("-")
          case argv.shift
          when "--name", "-n" then name_override = argv.shift
          when "--installer", "-i" then installer_override = argv.shift
          when "--help", "-h"
            $stderr.puts "Usage: onix import [--installer ruby|pnpm] [--name NAME] <path/to/Gemfile.lock|pnpm-lock.yaml|project>"
            exit 0
          end
        end

        if argv.empty?
          $stderr.puts "Usage: onix import [--installer ruby|pnpm] [--name NAME] <path/to/Gemfile.lock|pnpm-lock.yaml|project>"
          exit 1
        end

        lockfile, project_name, installer = resolve_lockfile(argv.first, name_override, installer_override)

        UI.header "Import #{UI.bold(project_name)}"
        UI.info lockfile

        if installer == "pnpm"
          import_pnpm(lockfile, project_name)
        else
          import_ruby(lockfile, project_name)
        end
      end

      private

      def resolve_lockfile(arg, name_override, installer_override)
        path = File.expand_path(arg)
        installer = installer_override

        if File.directory?(path)
          case installer
          when "pnpm"
            lockfile = find_directory_pnpm_lockfile(path)
            abort "No pnpm lockfile found in #{path}" unless lockfile
          when "ruby"
            lockfile = File.join(path, "Gemfile.lock")
            abort "No Gemfile.lock in #{path}" unless File.exist?(lockfile)
          else
            pnpm_lockfile = find_directory_pnpm_lockfile(path)
            ruby_lockfile = File.join(path, "Gemfile.lock")
            if pnpm_lockfile && File.exist?(pnpm_lockfile)
              installer = "pnpm"
              lockfile = pnpm_lockfile
            elsif File.exist?(ruby_lockfile)
              installer = "ruby"
              lockfile = ruby_lockfile
            else
              abort "No Gemfile.lock or pnpm lockfile in #{path}"
            end
          end
        else
          filename = File.basename(path)
          case filename
          when "Gemfile"
            lockfile = "#{path}.lock"
            abort "No Gemfile.lock found next to #{path}" unless File.exist?(lockfile)
            installer = "ruby" unless installer
          when "Gemfile.lock"
            lockfile = path
            installer = "ruby" unless installer
          else
            if filename.match?(%r{\A.+\.pnpm-lock\.ya?ml\z})
              lockfile = path
              installer = "pnpm" unless installer
            elsif File.exist?(path)
              abort "Unknown lockfile type: #{arg}"
            else
              abort "Not found: #{arg}"
            end
          end

          if installer_override
            unless installer_override == installer
              abort "Installer mismatch: requested #{installer_override}, detected #{installer}"
            end
          end
        end

        if installer.nil?
          abort "Could not detect installer for #{arg}; pass --installer ruby|pnpm"
        end

        project = name_override || File.basename(File.dirname(lockfile))
        [lockfile, project, installer]
      end

      def find_directory_pnpm_lockfile(path)
        candidates = [
          File.join(path, "pnpm-lock.yaml"),
          File.join(path, "pnpm-lock.yml"),
        ] +
          Dir.glob(File.join(path, "*.pnpm-lock.yaml")) +
          Dir.glob(File.join(path, "*.pnpm-lock.yml"))
        resolved = candidates.uniq.select { |candidate| File.file?(candidate) }

        return resolved.first if resolved.length == 1

        if resolved.length > 1
          abort "Multiple pnpm lockfiles found in #{path}; pass the lockfile path explicitly.\n  #{resolved.map { |file| File.basename(file) }.sort.join(", ")}"
        end

        nil
      end

      def import_pnpm(lockfile, project_name)
        lockdata = Pnpm::Lockfile.parse(lockfile)
        project_config = Pnpm::ProjectConfig.new(File.dirname(lockfile))
        project_config.enforce_manager_compatible_with(lockdata.lockfile_version)
        script_policy = project_config.script_policy
        importer = root_pnpm_importer(lockdata)
        package_manager = project_config.package_manager

        entries_by_key = {}

        add_node_imports(entries_by_key, importer.dependencies, ["default"], lockdata)
        add_node_imports(entries_by_key, importer.dev_dependencies, ["development"], lockdata)
        add_node_imports(entries_by_key, importer.optional_dependencies, ["optional"], lockdata)

        entries = entries_by_key.values

        UI.info "#{entries.size} node dependencies from #{File.basename(lockfile)}"

        meta = Packageset::Meta.new(
          ruby: nil,
          bundler: nil,
          platforms: [],
          package_manager: package_manager,
          script_policy: script_policy,
          lockfile_path: File.expand_path(lockfile),
          lockfile_relpath: lockfile_relpath(lockfile),
        )

        FileUtils.mkdir_p(@project.packagesets_dir)
        outpath = File.join(@project.packagesets_dir, "#{project_name}.jsonl")
        Packageset.write(outpath, meta: meta, entries: entries)

        UI.wrote "packagesets/#{project_name}.jsonl"
        UI.done "#{entries.size} packages"
      end

      def root_pnpm_importer(lockdata)
        importer = lockdata.importers["."]

        if importer
          return importer
        end

        if lockdata.importers.length == 1
          return lockdata.importers.values.first
        end

        abort "Root-only import requires importer '.' in pnpm-lock.yaml; found #{lockdata.importers.keys.sort.join(", ")}"
      end

      def add_node_imports(target, deps, groups, lockdata)
        deps.each do |name, dep|
          entry = build_node_entry(name, dep, groups, lockdata)
          key = "#{entry.name}/#{entry.version}"

          if target.key?(key)
            existing = target[key]
            existing.groups = (existing.groups + entry.groups).uniq
            existing.deps = (existing.deps + entry.deps).uniq
            next
          end

          target[key] = entry
        end
      end

      def build_node_entry(name, dep, groups, lockdata)
        dep_version = dep.version.to_s

        if dep_version.start_with?("link:")
          return Packageset::Entry.new(
            installer: "node",
            name: name,
            version: dep_version,
            source: "link",
            path: dep_version.sub("link:", ""),
            deps: [],
            groups: groups,
          )
        end

        if dep_version.start_with?("file:")
          return Packageset::Entry.new(
            installer: "node",
            name: name,
            version: dep_version,
            source: "file",
            path: dep_version.sub("file:", ""),
            deps: [],
            groups: groups,
          )
        end

        snapshot = lockdata.snapshot_for(name, dep_version)
        package_deps = snapshot && snapshot.dependencies ? snapshot.dependencies : {}

        Packageset::Entry.new(
          installer: "node",
          name: name,
          version: dep_version,
          source: "pnpm",
          deps: package_deps.keys,
          groups: groups,
        )
      end

      def import_ruby(lockfile, project_name)
        lockdata = Scint::Lockfile::Parser.parse(lockfile)
        credentials = Scint::Credentials.new
        credentials.register_lockfile_sources(lockdata.sources)

        # ── Build dependency map ─────────────────────────────────────
        # spec[:dependencies] is [{name:, version_reqs:}]
        dep_map = {}
        lockdata.specs.each do |spec|
          dep_map[spec[:name]] = spec[:dependencies].map { |d| d[:name] }
        end

        # ── Classify specs ───────────────────────────────────────────

        entries = []
        git_repos = {}  # key => { uri:, rev:, branch:, ... , gems: [] }
        rubygem_specs = {}  # name => [{ version:, platform:, source_uri:, deps: }]

        lockdata.specs.each do |spec|
          name = spec[:name]
          version = spec[:version]
          deps = dep_map[name] || []

          case spec[:source]
          when Scint::Source::Git
            src = spec[:source]
            rev = src.revision
            key = "#{src.name}-#{rev[0, 12]}"

            repo = (git_repos[key] ||= {
              uri: src.uri, rev: rev,
              branch: src.branch, tag: src.tag,
              submodules: src.submodules, glob: src.glob,
              base: src.name, gems: [],
            })
            repo[:gems] << { name: name, version: version, deps: deps }

          when Scint::Source::Path
            entries << Packageset::Entry.new(
              installer: "ruby", name: name, version: version,
              source: "path", path: spec[:source].path, deps: deps,
            )

          else
            # Rubygems — collect by name, prefer "ruby" platform over native
            platform = spec[:platform] || "ruby"
            source_uri = spec[:source].respond_to?(:uri) ? spec[:source].uri : "https://rubygems.org/"
            rubygem_specs[name] ||= []
            rubygem_specs[name] << { version: version, platform: platform, source_uri: source_uri, deps: deps }
          end
        end

        # Resolve platform: prefer "ruby" (source), fall back to matching native platform.
        # Platform is stored so generate knows the fetch slug for gems that ONLY
        # ship prebuilt (e.g. sorbet-static). For all others, platform is nil and
        # the source gem is fetched and built from source.
        local_platform = Gem::Platform.local.to_s.sub(/-\d+$/, "") # "arm64-darwin"
        rubygem_specs.each do |name, variants|
          ruby_variant = variants.find { |v| v[:platform] == "ruby" }
          native_variant = variants.find { |v| v[:platform]&.start_with?(local_platform) } ||
                           variants.find { |v| v[:platform] == "universal-darwin" }
          chosen = ruby_variant || native_variant || variants.first
          version = chosen[:version]
          source_uri = chosen[:source_uri]
          deps = chosen[:deps]
          # Only store platform when there's no ruby variant — generate will
          # try source first and use platform as fallback for fetch slug.
          platform = ruby_variant ? nil : chosen[:platform]
          platform = nil if platform == "ruby"

          if Packageset::RUBY_STDLIB.include?(name)
            entries << Packageset::Entry.new(
              installer: "ruby", name: name, version: version, source: "stdlib",
            )
          else
            entries << Packageset::Entry.new(
              installer: "ruby", name: name, version: version,
              platform: platform,
              source: "rubygems",
              remote: source_uri.chomp("/"),
              deps: deps,
            )
          end
        end

        UI.info "#{entries.count { |e| e.source == "rubygems" }} rubygems, " \
                "#{git_repos.values.sum { |r| r[:gems].size }} git (#{git_repos.size} repos), " \
                "#{entries.count { |e| e.source == "stdlib" }} stdlib, " \
                "#{entries.count { |e| e.source == "path" }} path"

        # ── Resolve git monorepo subdirectories ──────────────────────

        if git_repos.any?
          progress = UI::Progress.new(git_repos.size, label: "Resolve git repos")
          git_repos.each_value do |repo|
            subdirs = resolve_git_subdirs(repo)
            repo[:gems].each do |g|
              subdir = subdirs[g[:name]]
              entries << Packageset::Entry.new(
                installer: "ruby", name: g[:name], version: g[:version],
                source: "git", uri: repo[:uri], rev: repo[:rev],
                branch: repo[:branch], tag: repo[:tag],
                submodules: repo[:submodules],
                subdir: subdir,
                deps: g[:deps],
              )
            end
            progress.advance
          end
          progress.finish
        end

        # ── Enrich: scan for has_ext, require_paths, executables ─────
        # For rubygems, we'd need to download the gem to check. Instead
        # we'll detect has_ext at build time (check for ext/ dir).
        # For git gems with subdir, we already have the checkout.

        # ── Write JSONL packageset ───────────────────────────────────

        meta = Packageset::Meta.new(
          ruby: lockdata.ruby_version,
          bundler: lockdata.bundler_version,
          platforms: lockdata.platforms,
          lockfile_path: File.expand_path(lockfile),
          lockfile_relpath: lockfile_relpath(lockfile),
        )

        FileUtils.mkdir_p(@project.packagesets_dir)
        outpath = File.join(@project.packagesets_dir, "#{project_name}.jsonl")
        Packageset.write(outpath, meta: meta, entries: entries)

        UI.wrote "packagesets/#{project_name}.jsonl"
        UI.done "#{entries.size} packages"
      end

      # Clone a git repo and find which subdirectory each gem lives in.
      # Returns { "activesupport" => "activesupport", "rails" => ".", ... }
      def resolve_git_subdirs(repo)
        subdirs = {}

        Dir.mktmpdir("onix-git-") do |tmpdir|
          clone_dir = File.join(tmpdir, repo[:base])

          # Try shallow fetch of exact rev first, fall back to full clone
          _, status = Open3.capture2e(
            "git", "init", clone_dir
          )
          Open3.capture2e("git", "-C", clone_dir, "remote", "add", "origin", repo[:uri])

          # Try fetching just the one commit (works with most Git servers)
          _, status = Open3.capture2e(
            "git", "-C", clone_dir, "fetch", "--depth=1", "origin", repo[:rev]
          )
          unless status.success?
            # Fall back: fetch full history
            _, status = Open3.capture2e(
              "git", "-C", clone_dir, "fetch", "origin"
            )
            unless status.success?
              UI.warn "Failed to fetch #{repo[:uri]}"
              repo[:gems].each { |g| subdirs[g[:name]] = "." }
              return subdirs
            end
          end

          # Checkout the pinned revision
          _, status = Open3.capture2e(
            "git", "-C", clone_dir, "checkout", repo[:rev]
          )
          unless status.success?
            UI.warn "Failed to checkout #{repo[:rev]} in #{repo[:uri]}"
            repo[:gems].each { |g| subdirs[g[:name]] = "." }
            return subdirs
          end

          # Find all gemspecs and map gem names to directories
          gemspec_map = {}
          glob = repo[:glob] || "{,*,*/*}.gemspec"
          Dir.glob(File.join(clone_dir, glob)).each do |path|
            begin
              content = File.read(path)
              # Extract gem name from gemspec — look for .name = "foo" or .name = 'foo'
              if content =~ /\.name\s*=\s*["']([^"']+)["']/
                gem_name = $1
                rel_dir = File.dirname(path).sub("#{clone_dir}/", "").sub(clone_dir, ".")
                gemspec_map[gem_name] = rel_dir
              end
            rescue => e
              # Skip unparseable gemspecs
            end
          end

          # Map each gem to its subdirectory
          repo[:gems].each do |g|
            subdirs[g[:name]] = gemspec_map[g[:name]] || "."
          end
        end

        subdirs
      end

      def lockfile_relpath(lockfile)
        absolute = File.expand_path(lockfile)
        root =
          if @project.respond_to?(:root)
            File.expand_path(@project.root)
          elsif @project.respond_to?(:packagesets_dir)
            File.expand_path("..", @project.packagesets_dir)
          else
            return nil
          end
        prefix = root.end_with?("/") ? root : "#{root}/"
        return nil unless absolute.start_with?(prefix)

        absolute.delete_prefix(prefix)
      end
    end
  end
end
