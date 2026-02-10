# frozen_string_literal: true

require "scint/lockfile/parser"
require "scint/credentials"
require "open3"
require "fileutils"
require "json"
require "set"
require "tmpdir"
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

        while argv.first&.start_with?("-")
          case argv.shift
          when "--name", "-n" then name_override = argv.shift
          when "--help", "-h"
            $stderr.puts "Usage: onix import [--name NAME] <path/to/Gemfile.lock>"
            exit 0
          end
        end

        if argv.empty?
          $stderr.puts "Usage: onix import <path/to/Gemfile.lock>"
          exit 1
        end

        lockfile, project_name = resolve_lockfile(argv.first, name_override)

        UI.header "Import #{UI.bold(project_name)}"
        UI.info lockfile

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
            # Rubygems — skip platform variants, always use "ruby" platform
            platform = spec[:platform] || "ruby"
            next unless platform == "ruby"

            source_uri = spec[:source].respond_to?(:uri) ? spec[:source].uri : "https://rubygems.org/"

            if Packageset::RUBY_STDLIB.include?(name)
              entries << Packageset::Entry.new(
                installer: "ruby", name: name, version: version, source: "stdlib",
              )
            else
              entries << Packageset::Entry.new(
                installer: "ruby", name: name, version: version,
                source: "rubygems",
                remote: source_uri.chomp("/"),
                deps: deps,
              )
            end
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
        )

        FileUtils.mkdir_p(@project.packagesets_dir)
        outpath = File.join(@project.packagesets_dir, "#{project_name}.jsonl")
        Packageset.write(outpath, meta: meta, entries: entries)

        UI.wrote "packagesets/#{project_name}.jsonl"
        UI.done "#{entries.size} packages"
      end

      private

      def resolve_lockfile(arg, name_override)
        path = File.expand_path(arg)

        if File.directory?(path)
          lockfile = File.join(path, "Gemfile.lock")
          abort "No Gemfile.lock in #{path}" unless File.exist?(lockfile)
        elsif File.basename(path) == "Gemfile"
          lockfile = "#{path}.lock"
          abort "No Gemfile.lock found next to #{path}" unless File.exist?(lockfile)
        elsif File.exist?(path)
          lockfile = path
        else
          abort "Not found: #{arg}"
        end

        project = name_override || File.basename(File.dirname(lockfile))
        [lockfile, project]
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
    end
  end
end
