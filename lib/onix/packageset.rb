# frozen_string_literal: true

require "json"
require "set"

module Onix
  # A packageset is a JSONL file describing every package needed for a project.
  # Each line is a self-contained JSON object with everything needed for a
  # hermetic nix build — no external lookups required after import.
  #
  # Format:
  #   Line 1:  {"_meta":true, "ruby":"3.4.8", "bundler":"2.6.5", "platforms":["arm64-darwin","ruby"]}
  #   Line 2+: {"installer":"ruby", "name":"rack", "version":"3.1.12", "source":"rubygems", ...}
  #
  # See docs/packageset-format.md for the full spec.
  module Packageset
    # Ruby default gems — shipped with the Ruby binary, never need building.
    # From: nix ruby_3_4 specifications/default/
    RUBY_STDLIB = %w[
      benchmark bundler cgi date delegate did_you_mean digest english erb
      error_highlight etc fcntl fiddle fileutils find forwardable io-console
      io-nonblock io-wait ipaddr irb json logger net-http net-protocol open-uri
      open3 openssl optparse ostruct pathname pp prettyprint prism pstore psych
      rdoc readline reline resolv ruby2_keywords securerandom set shellwords
      singleton stringio strscan syntax_suggest tempfile time timeout tmpdir
      tsort un uri weakref yaml zlib
    ].to_set.freeze

    Entry = Struct.new(
      :installer,     # "ruby" | "node"
      :name,          # gem name
      :version,       # version string
      :source,        # "rubygems" | "git" | "path" | "stdlib"
      :importer,      # node importer name(s), comma-separated
      :integrity,     # node integrity string from lockfile resolution
      :resolution,    # node resolution metadata
      :os,            # node os constraints from lockfile
      :cpu,           # node cpu constraints from lockfile
      :libc,          # node libc constraints from lockfile
      :engines,       # node engines constraints from lockfile
      :platform,      # "ruby" (source) or "arm64-darwin" etc. (prebuilt-only, e.g. sorbet-static)
      :remote,        # gem server URL (rubygems only)
      :uri,           # git clone URL (git only)
      :rev,           # full git SHA (git only)
      :branch,        # git branch (informational)
      :tag,           # git tag (informational)
      :subdir,        # subdirectory within repo (git monorepos)
      :submodules,    # fetch submodules? (git only)
      :path,          # relative path (path source only)
      :deps,          # runtime dependency names
      :require_paths, # ["lib"] usually
      :executables,   # ["rails", "rake"]
      :has_ext,       # has native C/Rust extensions?
      :groups,        # ["default", "production"]
      keyword_init: true,
    ) do
      def to_jsonl
        h = { installer: installer, name: name, version: version, source: source }
        h[:importer] = importer if importer && !importer.empty?
        h[:integrity] = integrity if integrity && !integrity.empty?
        h[:resolution] = resolution if resolution
        h[:os] = os if os && !os.empty?
        h[:cpu] = cpu if cpu && !cpu.empty?
        h[:libc] = libc if libc && !libc.empty?
        h[:engines] = engines if engines && !engines.empty?
        h[:platform] = platform if platform && platform != "ruby"
        h[:remote] = remote if remote
        h[:uri] = uri if uri
        h[:rev] = rev if rev
        h[:branch] = branch if branch
        h[:tag] = tag if tag
        h[:subdir] = subdir if subdir && subdir != "."
        h[:submodules] = submodules if submodules
        h[:path] = path if path
        h[:deps] = deps if deps && !deps.empty?
        h[:require_paths] = require_paths if require_paths && require_paths != ["lib"]
        h[:executables] = executables if executables && !executables.empty?
        h[:has_ext] = true if has_ext
        h[:groups] = groups if groups && groups != ["default"]
        JSON.generate(h)
      end
    end

    Meta = Struct.new(
      :ruby,
      :bundler,
      :platforms,
      :package_manager,
      :script_policy,
      :lockfile_path,
      :node_version_major,
      :pnpm_version_major,
      keyword_init: true
    ) do
      def to_jsonl
        JSON.generate(
          _meta: true,
          ruby: ruby,
          bundler: bundler,
          platforms: platforms,
          package_manager: package_manager,
          script_policy: script_policy,
          lockfile_path: lockfile_path,
          node_version_major: node_version_major,
          pnpm_version_major: pnpm_version_major,
        )
      end
    end

    # Write a packageset to a JSONL file.
    def self.write(path, meta:, entries:)
      File.open(path, "w") do |f|
        f.puts meta.to_jsonl
        entries
          .sort_by { |e| [e.installer.to_s, e.name.to_s, e.version.to_s, e.source.to_s, e.path.to_s] }
          .each { |e| f.puts e.to_jsonl }
      end
    end

    # Read a packageset from a JSONL file.
    # Returns [meta, entries]
    def self.read(path)
      meta = nil
      entries = []

      File.foreach(path) do |line|
        line = line.strip
        next if line.empty? || line.start_with?("#")
        data = JSON.parse(line, symbolize_names: true)

        if data[:_meta]
          meta = Meta.new(
            ruby: data[:ruby],
            bundler: data[:bundler],
            platforms: data[:platforms] || [],
            package_manager: data[:package_manager],
            script_policy: data[:script_policy],
            lockfile_path: data[:lockfile_path],
            node_version_major: data[:node_version_major],
            pnpm_version_major: data[:pnpm_version_major],
          )
        else
          entries << Entry.new(
            installer: data[:installer] || "ruby",
            name: data[:name],
            version: data[:version],
            source: data[:source],
            importer: data[:importer],
            integrity: data[:integrity],
            resolution: normalize_hash_keys(data[:resolution]),
            os: data[:os],
            cpu: data[:cpu],
            libc: data[:libc],
            engines: normalize_hash_keys(data[:engines]),
            platform: data[:platform],
            remote: data[:remote],
            uri: data[:uri],
            rev: data[:rev],
            branch: data[:branch],
            tag: data[:tag],
            subdir: data[:subdir],
            submodules: data[:submodules],
            path: data[:path],
            deps: data[:deps] || [],
            require_paths: data[:require_paths] || ["lib"],
            executables: data[:executables] || [],
            has_ext: data[:has_ext] || false,
            groups: data[:groups] || ["default"],
          )
        end
      end

      [meta, entries]
    end

    def self.normalize_hash_keys(hash)
      return nil unless hash.is_a?(Hash)

      hash.each_with_object({}) do |(key, value), out|
        out[key.to_s] = value
      end
    end
  end
end
