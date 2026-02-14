# frozen_string_literal: true

require "json"

module Onix
  # A packageset is a JSONL file describing every package needed for a project.
  # Each line is a self-contained JSON object with everything needed for a
  # hermetic nix build — no external lookups required after import.
  #
  # Format:
  #   Line 1:  {"_meta":true, "ruby":"3.4.8", "bundler":"2.6.5", "platforms":["arm64-darwin","ruby"]}
  #   Line 2+: {"installer":"ruby", "name":"rack", "version":"3.1.12", "source":"rubygems", ...}
  #
  # Node format:
  #   Line 1:  {"_meta":true, "node":"22", "pnpm":"10", "platforms":["linux-x64","darwin-arm64"]}
  #   Line 2+: {"installer":"node", "name":"react", "version":"19.1.0", "source":"npm", ...}
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
      # ── Common fields (all installers) ──────────────────────────
      :installer,     # "ruby" | "node"
      :name,          # package name (gem name or npm package name)
      :version,       # version string
      :source,        # ruby: "rubygems" | "git" | "path" | "stdlib"
                      # node: "npm" | "git" | "path" | "builtin"
      :platform,      # ruby: "ruby" or "arm64-darwin" etc.
                      # node: nil or platform constraint string
      :remote,        # registry URL (rubygems server or npm registry)
      :uri,           # git clone URL (git only)
      :rev,           # full git SHA (git only)
      :branch,        # git branch (informational)
      :tag,           # git tag (informational)
      :subdir,        # subdirectory within repo (monorepos)
      :submodules,    # fetch submodules? (git only)
      :path,          # relative path (path source only)
      :deps,          # ruby: array of dependency names; node: hash {name => version}

      # ── Ruby-specific fields ────────────────────────────────────
      :require_paths, # ["lib"] usually
      :executables,   # ["rails", "rake"]
      :has_ext,       # has native C/Rust extensions?
      :groups,        # ["default", "production"]

      # ── Node-specific fields ────────────────────────────────────
      :bin,           # { "cli-name" => "./bin/cli.js" } — executable mappings
      :has_native,    # has node-gyp / napi native addon?
      :tarball,       # exact tarball URL from lockfile (private registries)
      :os,            # ["darwin", "linux"] — platform os constraints
      :cpu,           # ["x64", "arm64"] — platform cpu constraints
      :libc,          # ["glibc", "musl"] — platform libc constraints
      :integrity,     # "sha512-..." — tarball integrity from lockfile (for CAFS)

      keyword_init: true,
    ) do
      def to_jsonl
        h = { installer: installer, name: name, version: version, source: source }
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

        # Ruby-specific
        h[:require_paths] = require_paths if require_paths && require_paths != ["lib"]
        h[:executables] = executables if executables && !executables.empty?
        h[:has_ext] = true if has_ext
        h[:groups] = groups if groups && groups != ["default"]

        # Node-specific
        h[:bin] = bin if bin && !bin.empty?
        h[:has_native] = true if has_native
        h[:tarball] = tarball if tarball
        h[:os] = os if os && !os.empty?
        h[:cpu] = cpu if cpu && !cpu.empty?
        h[:libc] = libc if libc && !libc.empty?
        h[:integrity] = integrity if integrity

        JSON.generate(h)
      end

      def ruby_deps
        deps.is_a?(Array) ? deps : []
      end

      def node_deps
        deps.is_a?(Hash) ? deps : {}
      end

      def safe_nix_filename
        name.gsub("/", "--").gsub("@", "")
      end
    end

    Meta = Struct.new(
      :ruby, :bundler,   # Ruby ecosystem
      :node, :pnpm,      # Node ecosystem
      :platforms,         # Shared
      keyword_init: true,
    ) do
      def to_jsonl
        h = { _meta: true }
        h[:ruby] = ruby if ruby
        h[:bundler] = bundler if bundler
        h[:node] = node if node
        h[:pnpm] = pnpm if pnpm
        h[:platforms] = platforms if platforms && !platforms.empty?
        JSON.generate(h)
      end
    end

    # Normalize deps from JSON: symbolized hash keys → string keys, or default to [].
    def self.normalize_deps(raw)
      case raw
      when nil then []
      when Array then raw
      when Hash then raw.transform_keys(&:to_s)
      else []
      end
    end

    # Write a packageset to a JSONL file.
    def self.write(path, meta:, entries:)
      File.open(path, "w") do |f|
        f.puts meta.to_jsonl
        entries.sort_by(&:name).each { |e| f.puts e.to_jsonl }
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
            node: data[:node],
            pnpm: data[:pnpm],
            platforms: data[:platforms] || [],
          )
        else
          entries << Entry.new(
            installer: data[:installer] || "ruby",
            name: data[:name],
            version: data[:version],
            source: data[:source],
            platform: data[:platform],
            remote: data[:remote],
            uri: data[:uri],
            rev: data[:rev],
            branch: data[:branch],
            tag: data[:tag],
            subdir: data[:subdir],
            submodules: data[:submodules],
            path: data[:path],
            # deps: array of names (ruby) or hash {name => version} (node)
            deps: normalize_deps(data[:deps]),
            # Ruby
            require_paths: data[:require_paths] || ["lib"],
            executables: data[:executables] || [],
            has_ext: data[:has_ext] || false,
            groups: data[:groups] || ["default"],
            # Node
            bin: data[:bin] || {},
            has_native: data[:has_native] || false,
            tarball: data[:tarball],
            os: data[:os] || [],
            cpu: data[:cpu] || [],
            libc: data[:libc] || [],
            integrity: data[:integrity],
          )
        end
      end

      [meta, entries]
    end
  end
end
