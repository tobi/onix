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
      attr_reader :root, :packagesets_dir, :ruby_dir, :node_dir, :nix_dir, :overlays_dir

      def initialize(root)
        @root = root
        @packagesets_dir = File.join(root, "packagesets")
        @ruby_dir = File.join(root, "nix", "ruby")
        @node_dir = File.join(root, "nix", "node")
        @nix_dir = File.join(root, "nix")
        @overlays_dir = File.join(root, "overlays")
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

        File.write(File.join(dir, "nix", "node", "vite.nix"), "{}\n")

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
        assert_match(/vite/, message)
      end
    end

    def test_check_nix_eval_includes_nested_node_overlays
      Dir.mktmpdir do |dir|
        FileUtils.mkdir_p(File.join(dir, "nix"))
        FileUtils.mkdir_p(File.join(dir, "overlays", "node"))
        File.write(File.join(dir, "nix", "foo.nix"), "{}\n")
        File.write(File.join(dir, "overlays", "node", "vite.nix"), "{}\n")

        @command.instance_variable_set(:@project, StubProject.new(dir))
        status = Struct.new(:success?) { def success?; true; end }.new
        parsed = []

        Open3.stub(:capture3, ->(*args) do
          parsed << args.last
          ["", "", status]
        end) do
          ok, message = @command.send(:check_nix_eval)

          assert ok
          assert_match(/2 nix files parse OK/, message)
        end

        assert parsed.any? { |f| f.end_with?("overlays/node/vite.nix") }
        assert parsed.any? { |f| f.end_with?("nix/foo.nix") }
      end
    end

    def test_check_secrets_scans_log_directories
      Dir.mktmpdir do |dir|
        FileUtils.mkdir_p(File.join(dir, "log"))
        FileUtils.mkdir_p(File.join(dir, "packagesets"))
        bin_dir = File.join(dir, "bin")
        FileUtils.mkdir_p(bin_dir)
        gitleaks_bin = File.join(bin_dir, "gitleaks")
        File.write(gitleaks_bin, "#!/usr/bin/env sh\nexit 0\n")
        FileUtils.chmod(0o755, gitleaks_bin)
        old_path = ENV["PATH"]
        ENV["PATH"] = "#{bin_dir}:#{old_path}"

        @command.instance_variable_set(:@project, StubProject.new(dir))
        status = Struct.new(:success?) { def success?; true; end }.new
        args = []

        Open3.stub(:capture2e, lambda do |*capture_args|
          args << capture_args
          report_index = capture_args.index("--report-path")
          report_path = report_index && capture_args[report_index + 1]
          File.write(report_path, "[]") if report_path
          ["", "", status]
        end) do
          ok, message = @command.send(:check_secrets)

          assert ok
          assert_equal "clean", message
        end

        ENV["PATH"] = old_path

        sources = args.map { |call| call[call.index("--source") + 1] if call.include?("--source") }.compact
        assert_includes sources, File.join(dir, "log")
        assert_includes sources, File.join(dir, "packagesets")
      end
    end

    def test_check_packageset_metadata_warns_when_lockfile_path_missing
      Dir.mktmpdir do |dir|
        FileUtils.mkdir_p(File.join(dir, "packagesets"))

        Onix::Packageset.write(
          File.join(dir, "packagesets", "workspace.jsonl"),
          meta: Onix::Packageset::Meta.new(
            ruby: nil,
            bundler: nil,
            platforms: [],
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

        @command.instance_variable_set(:@project, StubProject.new(dir))
        ok, message = @command.send(:check_packageset_metadata)

        assert ok
        assert_match(/missing lockfile_path/, message)
        assert_match(/onix backfill/, message)
      end
    end

    def test_check_packageset_metadata_passes_with_lockfile_path
      Dir.mktmpdir do |dir|
        FileUtils.mkdir_p(File.join(dir, "packagesets"))

        Onix::Packageset.write(
          File.join(dir, "packagesets", "workspace.jsonl"),
          meta: Onix::Packageset::Meta.new(
            ruby: nil,
            bundler: nil,
            platforms: [],
            lockfile_path: File.join(dir, "pnpm-lock.yaml"),
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

        @command.instance_variable_set(:@project, StubProject.new(dir))
        ok, message = @command.send(:check_packageset_metadata)

        assert ok
        assert_equal "metadata complete", message
      end
    end

    def test_check_packageset_metadata_treats_external_lockfile_path_as_complete
      Dir.mktmpdir do |dir|
        FileUtils.mkdir_p(File.join(dir, "packagesets"))

        Onix::Packageset.write(
          File.join(dir, "packagesets", "workspace.jsonl"),
          meta: Onix::Packageset::Meta.new(
            ruby: nil,
            bundler: nil,
            platforms: [],
            lockfile_path: "/tmp/external/pnpm-lock.yaml",
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

        @command.instance_variable_set(:@project, StubProject.new(dir))
        ok, message = @command.send(:check_packageset_metadata)

        assert ok
        assert_equal "metadata complete", message
        refute_match(/onix backfill/, message)
      end
    end
  end
end
