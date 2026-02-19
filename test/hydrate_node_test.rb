# frozen_string_literal: true

require_relative "test_helper"
require_relative "../lib/onix/packageset"
require_relative "../lib/onix/commands/hydrate"

module Onix
  module UI
    class << self
      def header(*) ; end
      def info(*) ; end
      def wrote(*) ; end
      def done(*) ; end
      def fail(*) ; end
      def skip(*) ; end
      def bold(v) ; v ; end
      def green(v) ; v ; end
      def red(v) ; v ; end
      def amber(v) ; v ; end
      def dim(v) ; v ; end
      def format_time(v) ; v ; end
      def summary(*) ; end
    end
  end

  class HydrateNodeModulesTest < Minitest::Test
    class StubHydrate < Onix::Commands::Hydrate
      attr_reader :commands, :store_root

      def initialize
        @commands = []
        @keep_going = false
        @store_root = File.join(Dir.mktmpdir("onix-hydrate-store"), "node_modules")
        FileUtils.mkdir_p(@store_root)
      end

      def run_nix(cmd, return_paths: false, env: {})
        @commands << cmd
        return "/nix/store/fake-bundle" if cmd.include?("bundlePath")

        if cmd.include?("nodeModules")
          create_source_marker("v1") unless File.exist?(File.join(@store_root, ".node_modules_id"))
          return @store_root
        end

        "/nix/store/fake-return-path"
      end

      private

      def create_source_marker(value)
        source = File.join(@store_root, "node_modules")
        FileUtils.mkdir_p(source)
        FileUtils.mkdir_p(File.join(source, "vite"))
        File.write(File.join(source, "vite", "marker.txt"), value)
        File.write(File.join(@store_root, ".node_modules_id"), @store_root)
      end
    end

    def write_node_packageset(root, project_name, lockfile_path: nil)
      FileUtils.mkdir_p(File.join(root, "packagesets"))
      FileUtils.mkdir_p(File.join(root, "nix"))
      File.write(File.join(root, "nix", "#{project_name}.nix"), "{}\n")

      Onix::Packageset.write(
        File.join(root, "packagesets", "#{project_name}.jsonl"),
        meta: Onix::Packageset::Meta.new(
          ruby: nil,
          bundler: nil,
          platforms: [],
          lockfile_path: lockfile_path,
        ),
        entries: [
          Onix::Packageset::Entry.new(
            installer: "node",
            name: "vite",
            version: "5.0.0",
            source: "pnpm",
          ),
        ],
      )
    end

    def test_hydrate_uses_explicit_target_and_writes_target_marker
      Dir.mktmpdir do |dir|
        index = File.join(dir, "system", "onix-index")
        target = File.join(dir, "areas", "clients", "admin-web")
        FileUtils.mkdir_p(index)
        FileUtils.mkdir_p(target)
        write_node_packageset(index, "workspace")

        command = StubHydrate.new

        Dir.chdir(index) { command.run(["workspace", target]) }

        assert_equal "v1", File.read(File.join(target, "node_modules", "vite", "marker.txt"))
        assert_equal command.store_root, File.read(File.join(target, ".onix_node_modules_id")).strip
        refute File.exist?(File.join(index, ".onix_node_modules_id"))
      end
    end

    def test_hydrate_defaults_target_to_lockfile_directory
      Dir.mktmpdir do |dir|
        index = File.join(dir, "system", "onix-index")
        lockfile_dir = File.join(dir, "libraries", "javascript", "polaris")
        lockfile = File.join(lockfile_dir, "pnpm-lock.yaml")
        FileUtils.mkdir_p(index)
        FileUtils.mkdir_p(lockfile_dir)
        File.write(lockfile, "lockfileVersion: '9.0'\n")
        write_node_packageset(index, "workspace", lockfile_path: lockfile)

        command = StubHydrate.new

        Dir.chdir(index) { command.run(["workspace"]) }

        assert_equal "v1", File.read(File.join(lockfile_dir, "node_modules", "vite", "marker.txt"))
        assert_equal command.store_root, File.read(File.join(lockfile_dir, ".onix_node_modules_id")).strip
      end
    end

    def test_hydrate_fails_without_target_or_lockfile_path
      Dir.mktmpdir do |dir|
        index = File.join(dir, "system", "onix-index")
        FileUtils.mkdir_p(index)
        write_node_packageset(index, "workspace")

        command = StubHydrate.new
        error = assert_raises(SystemExit) do
          Dir.chdir(index) { command.run(["workspace"]) }
        end

        assert_equal 1, error.status
      end
    end
  end
end
