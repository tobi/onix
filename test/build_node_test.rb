# frozen_string_literal: true

require_relative "test_helper"
require_relative "../lib/onix/commands/build"
require_relative "../lib/onix/packageset"

module Onix
  module UI
    class << self
      def header(*) ; end
      def info(*) ; end
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

  class BuildNodeModulesTest < Minitest::Test
    class StubProject
      attr_reader :root

      def initialize(root)
        @root = root
      end

      def packagesets_dir
        File.join(root, "packagesets")
      end

      def nix_dir
        File.join(root, "nix")
      end

      def overlays_dir
        File.join(root, "overlays")
      end
    end

    class StubBuild < Onix::Commands::Build
      attr_reader :commands
      attr_reader :hydrations

      def initialize
        @commands = []
        @hydrations = []
        @keep_going = false
      end

      def run_nix(cmd, return_paths: false, env: {})
        @commands << cmd
        return "/nix/store/fake-bundle" if cmd.include?("bundlePath")
        return "/nix/store/fake-node" if cmd.include?("nodeModules")

        []
      end

      def hydrate_node_modules(path, options = {})
        @hydrations << [path, options]
      end
    end

    def test_hydrate_node_modules_copies_and_skips_by_sentinel
      Dir.mktmpdir do |dir|
        project = Onix::Commands::Build.new
        project.instance_variable_set(:@project, StubProject.new(dir))
        id = File.join(dir, "store", "x")

        source = File.join(id, "node_modules")
        FileUtils.mkdir_p(source)
        FileUtils.mkdir_p(File.join(source, "foo"))
        File.write(File.join(source, "foo", "marker.txt"), "v1")

        project.send(:hydrate_node_modules, id)
        target = File.join(dir, "node_modules")

        assert_equal "v1", File.read(File.join(target, "foo", "marker.txt"))
        assert_equal id, File.read(File.join(dir, ".node_modules_id")).strip
        assert_equal id, File.read(File.join(target, ".node_modules_id")).strip

        File.write(File.join(source, "foo", "marker.txt"), "v2")
        project.send(:hydrate_node_modules, id, skip_if_unchanged: true)

        assert_equal "v2", File.read(File.join(id, "node_modules", "foo", "marker.txt"))
        assert_equal "v1", File.read(File.join(target, "foo", "marker.txt"))
      end
    end

    def test_hydrate_node_modules_rehydrates_if_target_missing
      Dir.mktmpdir do |dir|
        project = Onix::Commands::Build.new
        project.instance_variable_set(:@project, StubProject.new(dir))
        id = File.join(dir, "store", "x")

        source = File.join(id, "node_modules")
        FileUtils.mkdir_p(source)
        FileUtils.mkdir_p(File.join(source, "foo"))
        File.write(File.join(source, "foo", "marker.txt"), "v1")

        project.send(:hydrate_node_modules, id)
        target = File.join(dir, "node_modules")

        assert_equal "v1", File.read(File.join(target, "foo", "marker.txt"))
        assert_equal id, File.read(File.join(dir, ".node_modules_id")).strip
        assert_equal id, File.read(File.join(target, ".node_modules_id")).strip

        File.write(File.join(source, "foo", "marker.txt"), "v2")
        FileUtils.rm_rf(target)

        project.send(:hydrate_node_modules, id, skip_if_unchanged: true)
        assert_equal "v2", File.read(File.join(target, "foo", "marker.txt"))
        assert_equal id, File.read(File.join(target, ".node_modules_id")).strip
      end
    end

    def test_build_project_uses_node_modules_target_for_node_projects
      Dir.mktmpdir do |dir|
        project_path = File.join(dir, "packagesets")
        FileUtils.mkdir_p(project_path)
        FileUtils.mkdir_p(File.join(dir, "nix"))
        File.write(File.join(dir, "nix", "workspace.nix"), "{}\n")

        entry = Onix::Packageset::Entry.new(
          installer: "node",
          name: "rimraf",
          version: "2.7.1",
          source: "pnpm",
          deps: ["glob"],
        )
        Onix::Packageset.write(
          File.join(project_path, "workspace.jsonl"),
          meta: Onix::Packageset::Meta.new(ruby: nil, bundler: nil, platforms: []),
          entries: [entry]
        )

        command = StubBuild.new
        command.instance_variable_set(:@project, StubProject.new(dir))
        command.instance_variable_set(:@commands, [])

        command.send(:build_project, "workspace")

        assert_equal 2, command.commands.size
        assert_equal ["nix-build", "--no-out-link", File.join(dir, "nix", "workspace.nix"), "-A", "bundlePath"], command.commands[0]
        assert_equal ["nix-build", "--no-out-link", File.join(dir, "nix", "workspace.nix"), "-A", "nodeModules"], command.commands[1]
        assert_equal [["/nix/store/fake-node", { skip_if_unchanged: true }]], command.hydrations
      end
    end

    def test_build_env_includes_runtime_tls_and_token_vars
      Dir.mktmpdir do |dir|
        command = StubBuild.new
        command.instance_variable_set(:@project, StubProject.new(dir))

        token = ENV["NPM_TOKEN"]
        ENV["NPM_TOKEN"] = "token-123"
        ENV["SSL_CERT_FILE"] = "/tmp/ca.pem"
        ENV["NODE_TLS_REJECT_UNAUTHORIZED"] = "0"

        env = command.send(:pnpm_build_env)

        assert_match "token-123", env["ONIX_NPM_TOKEN_LINES"]
        assert_equal "/tmp/ca.pem", env["SSL_CERT_FILE"]
        assert_equal "0", env["NODE_TLS_REJECT_UNAUTHORIZED"]
      ensure
        ENV["NPM_TOKEN"] = token
        ENV.delete("SSL_CERT_FILE")
        ENV.delete("NODE_TLS_REJECT_UNAUTHORIZED")
      end
    end

    def test_build_node_modules_transmits_env_to_nix
      Dir.mktmpdir do |dir|
        command = StubBuild.new
        command.instance_variable_set(:@project, StubProject.new(dir))

        captured_env = nil
        command.define_singleton_method(:run_nix) do |cmd, return_paths: false, env: {}|
          captured_env = env.dup
          if cmd.include?("nodeModules")
            "/nix/store/fake-node"
          else
            super(cmd, return_paths: return_paths, env: env)
          end
        end

        token = ENV["NPM_TOKEN"]
        ENV["NPM_TOKEN"] = "token-456"
        ENV["SSL_CERT_FILE"] = "/tmp/ca.pem"

        project_file = File.join(dir, "packagesets")
        FileUtils.mkdir_p(project_file)
        FileUtils.mkdir_p(File.join(dir, "nix"))
        Onix::Packageset.write(
          File.join(project_file, "workspace.jsonl"),
          meta: Onix::Packageset::Meta.new(ruby: nil, bundler: nil, platforms: []),
          entries: [
            Onix::Packageset::Entry.new(installer: "node", name: "vite", version: "5.0.0", source: "pnpm"),
          ],
        )
        File.write(File.join(dir, "nix", "workspace.nix"), "{}\n")
        command.send(:build_node_modules, "workspace")

        assert_includes(captured_env.keys, "ONIX_NPM_TOKEN_LINES")
        assert_includes(captured_env["ONIX_NPM_TOKEN_LINES"], "token-456")
        assert_equal "/tmp/ca.pem", captured_env["SSL_CERT_FILE"]
      ensure
        ENV["NPM_TOKEN"] = token
        ENV.delete("SSL_CERT_FILE")
      end
    end
  end
end
