# frozen_string_literal: true

require_relative "test_helper"
require "onix/packageset"

class PackagesetTest < Minitest::Test
  def test_write_sorts_entries_deterministically_for_duplicate_names
    Dir.mktmpdir do |dir|
      path = File.join(dir, "packageset.jsonl")
      entries = [
        Onix::Packageset::Entry.new(installer: "node", name: "dup", version: "2.0.0", source: "pnpm"),
        Onix::Packageset::Entry.new(installer: "ruby", name: "dup", version: "1.0.0", source: "rubygems", remote: "https://rubygems.org"),
        Onix::Packageset::Entry.new(installer: "node", name: "dup", version: "1.0.0", source: "pnpm"),
      ]

      Onix::Packageset.write(
        path,
        meta: Onix::Packageset::Meta.new(ruby: nil, bundler: nil, platforms: []),
        entries: entries,
      )

      parsed_meta, parsed_entries = Onix::Packageset.read(path)
      assert_equal(
        [
          "node/dup/1.0.0/pnpm",
          "node/dup/2.0.0/pnpm",
          "ruby/dup/1.0.0/rubygems",
        ],
        parsed_entries.map { |entry| "#{entry.installer}/#{entry.name}/#{entry.version}/#{entry.source}" },
      )
      assert_nil parsed_meta.lockfile_path
    end
  end

  def test_round_trips_extended_node_fields_and_meta
    Dir.mktmpdir do |dir|
      path = File.join(dir, "packageset.jsonl")
      entry = Onix::Packageset::Entry.new(
        installer: "node",
        name: "react",
        version: "19.0.0",
        source: "pnpm",
        importer: ".",
        integrity: "sha512-abc",
        resolution: { "integrity" => "sha512-abc" },
        os: ["darwin", "linux"],
        cpu: ["x64", "arm64"],
        libc: ["glibc"],
        engines: { "node" => ">=18" },
      )
      meta = Onix::Packageset::Meta.new(
        ruby: nil,
        bundler: nil,
        platforms: [],
        package_manager: "pnpm@10.0.0",
        script_policy: "allowed",
        node_version_major: 22,
        pnpm_version_major: 10,
      )

      Onix::Packageset.write(path, meta: meta, entries: [entry])
      parsed_meta, parsed_entries = Onix::Packageset.read(path)
      parsed = parsed_entries.first

      assert_equal ".", parsed.importer
      assert_equal "sha512-abc", parsed.integrity
      assert_equal({ "integrity" => "sha512-abc" }, parsed.resolution)
      assert_equal ["darwin", "linux"], parsed.os
      assert_equal ["x64", "arm64"], parsed.cpu
      assert_equal ["glibc"], parsed.libc
      assert_equal({ "node" => ">=18" }, parsed.engines)
      assert_equal 22, parsed_meta.node_version_major
      assert_equal 10, parsed_meta.pnpm_version_major
    end
  end
end
