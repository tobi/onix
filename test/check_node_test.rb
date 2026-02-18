# frozen_string_literal: true

require_relative "test_helper"
require_relative "../lib/onix/commands/check"
require_relative "../lib/onix/packageset"

module Onix
  module UI
    class << self
      def header(*) ; end
      def info(*) ; end
      def done(*) ; end
      def fail(*) ; end
      def skip(*) ; end
    end
  end

  class CheckNodeTest < Minitest::Test
    class StubProject
      attr_reader :root, :packagesets_dir, :ruby_dir, :node_dir

      def initialize(root)
        @root = root
        @packagesets_dir = File.join(root, "packagesets")
        @ruby_dir = File.join(root, "nix", "ruby")
        @node_dir = File.join(root, "nix", "node")
      end
    end

    def setup
      @command = Onix::Commands::Check.new
    end

    def test_check_packageset_complete_includes_node_entries
      Dir.mktmpdir do |dir|
        FileUtils.mkdir_p(File.join(dir, "packagesets"))
        FileUtils.mkdir_p(File.join(dir, "nix", "node"))

        entries = [
          Onix::Packageset::Entry.new(
            installer: "node",
            name: "vite",
            version: "5.0.0",
            source: "pnpm",
            deps: ["esbuild"],
          ),
        ]
        Onix::Packageset.write(
          File.join(dir, "packagesets", "workspace.jsonl"),
          meta: Onix::Packageset::Meta.new(ruby: nil, bundler: nil, platforms: []),
          entries: entries
        )

        File.write(File.join(dir, "nix", "node", "workspace.nix"), "{}\n")

        @command.instance_variable_set(:@project, StubProject.new(dir))
        ok, message = @command.send(:check_packageset_complete)

        assert ok
        assert_match(/1 packages all have generated files/, message)
      end
    end

    def test_check_packageset_complete_flags_missing_node_project_file
      Dir.mktmpdir do |dir|
        FileUtils.mkdir_p(File.join(dir, "packagesets"))
        FileUtils.mkdir_p(File.join(dir, "nix", "node"))

        entries = [
          Onix::Packageset::Entry.new(
            installer: "node",
            name: "vite",
            version: "5.0.0",
            source: "pnpm",
            deps: ["esbuild"],
          ),
        ]
        Onix::Packageset.write(
          File.join(dir, "packagesets", "workspace.jsonl"),
          meta: Onix::Packageset::Meta.new(ruby: nil, bundler: nil, platforms: []),
          entries: entries
        )

        @command.instance_variable_set(:@project, StubProject.new(dir))
        ok, message = @command.send(:check_packageset_complete)

        refute ok
        assert_match(/1 packages missing from generated files/, message)
        assert_match(/workspace/, message)
      end
    end
  end
end
