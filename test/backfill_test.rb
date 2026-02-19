# frozen_string_literal: true

require_relative "test_helper"
require_relative "../lib/onix/project"
require_relative "../lib/onix/packageset"
require_relative "../lib/onix/commands/backfill"

module Onix
  module UI
    class << self
      def header(*) ; end
      def info(*) ; end
      def wrote(*) ; end
      def done(*) ; end
      def fail(*) ; end
    end
  end
end

class BackfillTest < Minitest::Test
  def test_backfill_preserves_existing_lockfile_path
    Dir.mktmpdir do |dir|
      packagesets_dir = File.join(dir, "packagesets")
      FileUtils.mkdir_p(packagesets_dir)
      File.write(File.join(dir, "pnpm-lock.yaml"), "lockfileVersion: '9.0'\n")

      Onix::Packageset.write(
        File.join(packagesets_dir, "workspace.jsonl"),
        meta: Onix::Packageset::Meta.new(
          ruby: nil,
          bundler: nil,
          platforms: [],
          lockfile_path: File.join(dir, "pnpm-lock.yaml"),
        ),
        entries: [
          Onix::Packageset::Entry.new(installer: "node", name: "vite", version: "5.0.0", source: "pnpm"),
        ],
      )

      Dir.chdir(dir) { Onix::Commands::Backfill.new.run([]) }

      meta, = Onix::Packageset.read(File.join(packagesets_dir, "workspace.jsonl"))
      assert_equal File.realpath(File.join(dir, "pnpm-lock.yaml")), meta.lockfile_path
    end
  end

  def test_backfill_fills_lockfile_path_from_heuristics
    Dir.mktmpdir do |dir|
      packagesets_dir = File.join(dir, "packagesets")
      FileUtils.mkdir_p(packagesets_dir)
      lockfile = File.join(dir, "workspace.pnpm-lock.yaml")
      File.write(lockfile, "lockfileVersion: '9.0'\n")

      Onix::Packageset.write(
        File.join(packagesets_dir, "workspace.jsonl"),
        meta: Onix::Packageset::Meta.new(
          ruby: nil,
          bundler: nil,
          platforms: [],
        ),
        entries: [
          Onix::Packageset::Entry.new(installer: "node", name: "vite", version: "5.0.0", source: "pnpm"),
        ],
      )

      Dir.chdir(dir) { Onix::Commands::Backfill.new.run([]) }

      meta, = Onix::Packageset.read(File.join(packagesets_dir, "workspace.jsonl"))
      assert_equal File.realpath(lockfile), meta.lockfile_path
    end
  end

  def test_backfill_prefers_lockfile_path_over_heuristics
    Dir.mktmpdir do |dir|
      packagesets_dir = File.join(dir, "packagesets")
      FileUtils.mkdir_p(packagesets_dir)
      stale_lockfile = File.join(dir, "pnpm-lock.yaml")
      File.write(stale_lockfile, "lockfileVersion: '9.0'\n")

      external_root = Dir.mktmpdir("onix-external")
      external_lockfile = File.join(external_root, "pnpm-lock.yaml")
      File.write(external_lockfile, "lockfileVersion: '9.0'\n")

      Onix::Packageset.write(
        File.join(packagesets_dir, "workspace.jsonl"),
        meta: Onix::Packageset::Meta.new(
          ruby: nil,
          bundler: nil,
          platforms: [],
          lockfile_path: external_lockfile,
        ),
        entries: [
          Onix::Packageset::Entry.new(installer: "node", name: "vite", version: "5.0.0", source: "pnpm"),
        ],
      )

      Dir.chdir(dir) { Onix::Commands::Backfill.new.run([]) }

      meta, = Onix::Packageset.read(File.join(packagesets_dir, "workspace.jsonl"))
      assert_equal File.realpath(external_lockfile), meta.lockfile_path
    end
  end
end
