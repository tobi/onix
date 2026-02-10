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

    Meta = Struct.new(:ruby, :bundler, :platforms, keyword_init: true) do
      def to_jsonl
        JSON.generate({ _meta: true, ruby: ruby, bundler: bundler, platforms: platforms })
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
            platforms: data[:platforms] || [],
          )
        else
          entries << Entry.new(
            installer: data[:installer] || "ruby",
            name: data[:name],
            version: data[:version],
            source: data[:source],
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
  end
end
