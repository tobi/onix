# frozen_string_literal: true

require_relative "test_helper"
require_relative "../lib/onix/project"
require_relative "../lib/onix/commands/import"
require_relative "../lib/onix/commands/generate"
require_relative "../lib/onix/commands/build"

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

  class PnpmPipelineTest < Minitest::Test
    class StubBuildNodeProject < Onix::Commands::Build
      attr_reader :run_calls
      attr_reader :node_modules_root

      def initialize
        @run_calls = Hash.new(0)
        @keep_going = false
        @node_modules_root = File.join(Dir.mktmpdir("onix-pipeline-node"), "node_modules")
        FileUtils.mkdir_p(@node_modules_root)
      end

      def create_node_marker(value)
        source = File.join(@node_modules_root, "node_modules")
        FileUtils.mkdir_p(source)
        FileUtils.mkdir_p(File.join(source, "vite"))
        File.write(File.join(source, "vite", "marker.txt"), value)
        File.write(File.join(@node_modules_root, ".node_modules_id"), @node_modules_root)
      end

      def run_nix(cmd, return_paths: false, env: {})
        @run_calls[cmd.join(" ")] += 1

        return "/nix/store/fake-bundle" if cmd.include?("bundlePath")

        if cmd.include?("nodeModules")
          create_node_marker("v1") unless File.exist?(File.join(@node_modules_root, ".node_modules_id"))
          return @node_modules_root
        end

        "/nix/store/fake-return"
      end
    end

    def test_import_generate_build_then_hydrate_uses_sentinel_fast_path
      Dir.mktmpdir do |dir|
        project = File.join(dir, "workspace")
        FileUtils.mkdir_p(project)
        File.write(File.join(project, "pnpm-lock.yaml"), File.read(fixture_path("pnpm", "simple", "pnpm-lock.yaml")))
        File.write(File.join(project, "package.json"), "{}\n")

        Dir.chdir(dir) do
          importer = Onix::Commands::Import.new
          importer.run([project])
        end

        generator = Onix::Commands::Generate.new
        generator.singleton_class.prepend(Module.new do
          def prefetch_pnpm_deps_hash(*)
            "sha256-dummy"
          end
        end)
        Dir.chdir(dir) { generator.run([]) }

        command = StubBuildNodeProject.new
        command.instance_variable_set(:@project, Onix::Project.new(dir))
        command.send(:build_project, "workspace")
        command.send(:hydrate_node_modules, command.node_modules_root, target_root: dir, skip_if_unchanged: true)

        command.create_node_marker("v2")
        command.send(:build_project, "workspace")
        command.send(:hydrate_node_modules, command.node_modules_root, target_root: dir, skip_if_unchanged: true)

        target = File.join(dir, "node_modules")
        assert_equal "v1", File.read(File.join(target, "vite", "marker.txt"))
        assert_equal command.node_modules_root, File.read(File.join(dir, ".onix_node_modules_id")).strip
        assert_equal 2, command.run_calls.select { |k, _| k.include?("nodeModules") }.values.sum
        assert_equal 2, command.run_calls.select { |k, _| k.include?("bundlePath") }.values.sum
      end
    end
  end
end
