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
end
