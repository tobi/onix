# frozen_string_literal: true

require "yaml"
require "fileutils"
require "uri"
require_relative "../packageset"
require_relative "../npmrc"

module Onix
  module Commands
    # `onix import-pnpm` — parse pnpm-lock.yaml and produce a hermetic JSONL packageset.
    #
    # This is the pnpm equivalent of `onix import` (which handles Gemfile.lock).
    # The output is a JSONL packageset with installer:"node" entries.
    #
    class ImportPnpm
      DEFAULT_REGISTRY = "https://registry.npmjs.org"

      def run(argv)
        @project = Project.new
        name_override = nil
        node_version = nil

        while argv.first&.start_with?("-")
          case argv.shift
          when "--name", "-n" then name_override = argv.shift
          when "--node-version" then node_version = argv.shift
          when "--help", "-h"
            $stderr.puts "Usage: onix import-pnpm [--name NAME] [--node-version VER] <path/to/pnpm-lock.yaml>"
            exit 0
          end
        end

        if argv.empty?
          $stderr.puts "Usage: onix import-pnpm [--name NAME] [--node-version VER] <path/to/pnpm-lock.yaml>"
          exit 1
        end

        lockfile, project_name = resolve_lockfile(argv.first, name_override)
        @npmrc = Npmrc.new

        UI.header "Import (pnpm)"
        UI.info lockfile

        lock = YAML.safe_load(File.read(lockfile), permitted_classes: [Symbol])

        # Validate lockfile version — we require v9.0+ (pnpm 9/10/11)
        lf_version = lock["lockfileVersion"]&.to_s
        lf_major = lf_version&.split(".")&.first&.to_i || 0
        if lf_major < 9
          UI.fail "Unsupported pnpm lockfile version: #{lf_version || "unknown"}"
          UI.info "onix requires pnpm-lock.yaml v9.0+ (pnpm >= 9.0)"
          UI.info "Upgrade with: pnpm install (using pnpm >= 9.0)"
          exit 1
        end

        packages_section = lock["packages"] || {}
        snapshots_section = lock["snapshots"] || {}

        # ── Classify specs ───────────────────────────────────────────

        entries = []
        @seen = Set.new
        git_entries = []
        @packages_section = packages_section
        @snapshots_section = snapshots_section

        # Collect world dep names (custom:* resolution) to skip
        @world_dep_names = Set.new
        packages_section.each do |key, entry|
          res = entry&.dig("resolution") || {}
          if res["type"]&.start_with?("custom:")
            parsed = parse_spec(strip_peers(key))
            @world_dep_names.add(parsed[:name]) if parsed
          end
        end

        if @world_dep_names.any?
          UI.info "Skipping #{@world_dep_names.size} world deps: #{@world_dep_names.to_a.join(", ")}"
        end

        [packages_section, snapshots_section].each do |section|
          section.each do |key, entry|
            process_lockfile_entry(key, entry, entries, git_entries)
          end
        end

        # ── Git-sourced packages ──────────────────────────────────────

        git_entries.each do |g|
          entries << Packageset::Entry.new(
            installer: "node",
            name: g[:name],
            version: g[:version],
            source: "git",
            uri: g[:url],
            rev: g[:rev],
          )
        end

        npm_count = entries.count { |e| e.source == "npm" }
        git_count = entries.count { |e| e.source == "git" }
        UI.info "#{npm_count} npm, #{git_count} git"

        # ── Write JSONL packageset ────────────────────────────────────

        meta = Packageset::Meta.new(
          node: node_version,
          pnpm: lock["lockfileVersion"]&.to_s,
          platforms: detect_platforms(entries),
        )

        FileUtils.mkdir_p(@project.packagesets_dir)
        outpath = File.join(@project.packagesets_dir, "#{project_name}.jsonl")
        Packageset.write(outpath, meta: meta, entries: entries)

        UI.wrote "packagesets/#{project_name}.jsonl"
        UI.done "#{entries.size} packages"
      end

      private

      def process_lockfile_entry(key, entry, entries, git_entries)
        resolution = entry.is_a?(Hash) ? (entry["resolution"] || {}) : {}

        # Skip world zone dependencies
        return if resolution["type"]&.start_with?("custom:")

        clean = strip_peers(key)
        parsed = parse_spec(clean)
        return unless parsed
        return if @world_dep_names.include?(parsed[:name])

        spec_key = "#{parsed[:name]}@#{parsed[:version]}"
        return unless @seen.add?(spec_key)

        return if handle_git_entry(parsed, resolution, git_entries)
        return if skip_non_version_spec?(parsed[:version])

        pkg_meta = extract_package_metadata(spec_key, key)
        snap_data = extract_snapshot_data(spec_key, key)
        entries << build_npm_entry(parsed, pkg_meta, snap_data)
      end

      def handle_git_entry(parsed, resolution, git_entries)
        return false unless resolution["type"] == "git" && resolution["repo"] && resolution["commit"]

        git_entries << {
          name: parsed[:name],
          version: parsed[:version],
          url: resolution["repo"],
          rev: resolution["commit"],
        }
        true
      end

      def skip_non_version_spec?(version)
        version.match?(/^(file:|link:|workspace:|deprecated:)/) || version.include?(":")
      end

      def extract_package_metadata(spec_key, key)
        pkg_entry = @packages_section[spec_key] || @packages_section[key]
        pkg_entry.is_a?(Hash) ? pkg_entry : {}
      end

      def extract_snapshot_data(spec_key, key)
        snap_entry = @snapshots_section[spec_key] || @snapshots_section[key]
        snap_entry.is_a?(Hash) ? snap_entry : {}
      end

      def build_npm_entry(parsed, pkg_meta, snap_data)
        # Extract tarball URL and integrity from lockfile resolution
        resolution = pkg_meta["resolution"] || {}
        tarball_url = resolution["tarball"]
        integrity = resolution["integrity"]

        # Determine registry: tarball URL > .npmrc scope registry > default
        remote = if tarball_url
          uri = URI.parse(tarball_url) rescue nil
          uri ? "#{uri.scheme}://#{uri.host}#{uri.path.sub(%r{/[^/]+/-/.*}, "")}" : DEFAULT_REGISTRY
        else
          @npmrc&.registry_for(parsed[:name]) || DEFAULT_REGISTRY
        end

        Packageset::Entry.new(
          installer: "node",
          name: parsed[:name],
          version: parsed[:version],
          source: "npm",
          remote: remote,
          tarball: tarball_url,
          deps: extract_versioned_deps(snap_data),
          bin: extract_bin_entries(parsed[:name], pkg_meta),
          has_native: detect_native_addon(pkg_meta),
          os: extract_platform_list(pkg_meta, "os"),
          cpu: extract_platform_list(pkg_meta, "cpu"),
          libc: extract_platform_list(pkg_meta, "libc"),
          integrity: integrity,
        )
      end

      def extract_versioned_deps(snap_data)
        versioned_deps = {}
        %w[dependencies optionalDependencies].each do |section_name|
          dep_section = snap_data[section_name]
          next unless dep_section.is_a?(Hash)
          dep_section.each { |dep_name, dep_ver| versioned_deps[dep_name] = dep_ver.to_s }
        end
        versioned_deps
      end

      def extract_bin_entries(pkg_name, pkg_meta)
        case pkg_meta["bin"]
        when String
          short_name = pkg_name.split("/").last
          { short_name => pkg_meta["bin"] }
        when Hash
          pkg_meta["bin"]
        else
          {}
        end
      end

      def detect_native_addon(pkg_meta)
        has_gyp = pkg_meta.dig("scripts", "install")&.include?("node-gyp") || pkg_meta["gypfile"] == true
        !!(has_gyp && pkg_meta["hasBin"] == false)
      end

      def extract_platform_list(pkg_meta, key)
        pkg_meta[key] ? Array(pkg_meta[key]).map(&:to_s) : []
      end

      def resolve_lockfile(arg, name_override)
        path = File.expand_path(arg)

        if File.directory?(path)
          lockfile = File.join(path, "pnpm-lock.yaml")
          abort "No pnpm-lock.yaml in #{path}" unless File.exist?(lockfile)
        elsif File.basename(path) == "package.json"
          lockfile = File.join(File.dirname(path), "pnpm-lock.yaml")
          abort "No pnpm-lock.yaml found next to #{path}" unless File.exist?(lockfile)
        elsif File.exist?(path)
          lockfile = path
        else
          abort "Not found: #{arg}"
        end

        project = name_override || File.basename(File.dirname(lockfile))
        [lockfile, project]
      end

      # Parse a pnpm spec key into {name:, version:}.
      # Examples:
      #   "react@19.1.0"         → {name: "react", version: "19.1.0"}
      #   "@babel/core@7.26.0"   → {name: "@babel/core", version: "7.26.0"}
      # Returns nil if the spec cannot be parsed.
      def parse_spec(spec)
        return nil unless spec.include?("@")

        if spec.start_with?("@")
          idx = spec.index("@", 1)
          return nil unless idx
          name = spec[0...idx]
          version = spec[(idx + 1)..]
        else
          idx = spec.rindex("@")
          return nil unless idx && idx > 0
          name = spec[0...idx]
          version = spec[(idx + 1)..]
        end

        return nil if name.empty? || version.empty?
        { name: name, version: version }
      end

      # Strip pnpm peer dependency suffixes: "react@18.2.0(some-peer@1.0.0)" → "react@18.2.0"
      def strip_peers(spec)
        spec.sub(/\(.*\)$/, "")
      end

      # Detect platform strings from os/cpu constraints in entries
      def detect_platforms(entries)
        platforms = Set.new
        entries.each do |e|
          next if e.os.empty? && e.cpu.empty?
          e.os.each do |os|
            next if os.start_with?("!")
            e.cpu.each do |cpu|
              next if cpu.start_with?("!")
              platforms.add("#{cpu}-#{os}")
            end
            platforms.add(os) if e.cpu.empty?
          end
        end
        platforms.to_a.sort
      end
    end
  end
end
