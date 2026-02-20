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

    def with_clean_npm_token_env
      saved = {}
      ENV.each_key do |key|
        next unless key == "NPM_TOKEN" || key == "NODE_AUTH_TOKEN" || key.start_with?("NPM_TOKEN_")

        saved[key] = ENV[key]
      end

      saved.each_key { |key| ENV.delete(key) }
      yield
    ensure
      saved.each { |key, value| ENV[key] = value }
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

        project.send(:hydrate_node_modules, id, target_root: dir)
        target = File.join(dir, "node_modules")

        assert_equal "v1", File.read(File.join(target, "foo", "marker.txt"))
        assert_equal id, File.read(File.join(dir, ".onix_node_modules_id")).strip

        File.write(File.join(source, "foo", "marker.txt"), "v2")
        project.send(:hydrate_node_modules, id, target_root: dir, skip_if_unchanged: true)

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

        project.send(:hydrate_node_modules, id, target_root: dir)
        target = File.join(dir, "node_modules")

        assert_equal "v1", File.read(File.join(target, "foo", "marker.txt"))
        assert_equal id, File.read(File.join(dir, ".onix_node_modules_id")).strip

        File.write(File.join(source, "foo", "marker.txt"), "v2")
        FileUtils.rm_rf(target)

        project.send(:hydrate_node_modules, id, target_root: dir, skip_if_unchanged: true)
        assert_equal "v2", File.read(File.join(target, "foo", "marker.txt"))
        assert_equal id, File.read(File.join(dir, ".onix_node_modules_id")).strip
      end
    end

    def test_hydrate_node_modules_rehydrates_when_identity_marker_changes
      Dir.mktmpdir do |dir|
        project = Onix::Commands::Build.new
        project.instance_variable_set(:@project, StubProject.new(dir))
        id = File.join(dir, "store", "x")

        source = File.join(id, "node_modules")
        FileUtils.mkdir_p(source)
        FileUtils.mkdir_p(File.join(source, "foo"))
        File.write(File.join(source, "foo", "marker.txt"), "v1")
        File.write(File.join(id, ".node_modules_id"), "identity-v1")

        project.send(:hydrate_node_modules, id, target_root: dir)
        target = File.join(dir, "node_modules")

        assert_equal "v1", File.read(File.join(target, "foo", "marker.txt"))
        assert_equal "identity-v1", File.read(File.join(dir, ".onix_node_modules_id")).strip

        File.write(File.join(source, "foo", "marker.txt"), "version-two")
        File.write(File.join(id, ".node_modules_id"), "identity-v2")

        project.send(:hydrate_node_modules, id, target_root: dir, skip_if_unchanged: true)
        assert_equal "version-two", File.read(File.join(target, "foo", "marker.txt"))
        assert_equal "identity-v2", File.read(File.join(dir, ".onix_node_modules_id")).strip
      end
    end

    def test_build_project_builds_node_modules_without_hydration_for_node_projects
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
        assert_equal [], command.hydrations
      end
    end

  class StubRunNixBuild < Onix::Commands::Build
      attr_reader :direct_calls

      def initialize
        @direct_calls = []
        @keep_going = false
      end

      def run_nix_direct(cmd, _t0, out_link: nil, return_paths: false, env: {})
        @direct_calls << {
          command: cmd.dup,
          out_link: out_link,
          return_paths: return_paths,
          env: env,
        }

        if return_paths && out_link
          FileUtils.rm_f(out_link)
          FileUtils.mkdir_p(File.dirname(out_link))
          fake_store = File.join(Dir.mktmpdir("onix-run-nix"), "node_modules")
          FileUtils.mkdir_p(fake_store)
          File.symlink(fake_store, out_link)
          return fake_store
        end

        "/nix/store/fake-return-path"
      end

      def hydrate_node_modules(*)
        # no-op
      end
    end

    class StubBuildNodeModules < Onix::Commands::Build
      attr_reader :run_calls
      attr_reader :store_root

      def initialize
        @run_calls = 0
        @keep_going = false
        @store_root = File.join(Dir.mktmpdir("onix-node-store"), "node_modules")
        FileUtils.mkdir_p(@store_root)
      end

      def run_nix(cmd, return_paths: false, env: {})
        @run_calls += 1

        return super if !cmd.include?("nodeModules")

        marker = File.join(@store_root, ".node_modules_id")
        File.write(marker, "#{@store_root}\n") unless File.exist?(marker)

        @store_root
      end

      def create_source_marker(value)
        node_modules = File.join(@store_root, "node_modules")
        FileUtils.mkdir_p(node_modules)
        FileUtils.mkdir_p(File.join(node_modules, "foo"))
        File.write(File.join(node_modules, "foo", "marker.txt"), value)
      end
    end

    def test_build_node_modules_returns_store_path_without_hydration
      Dir.mktmpdir do |dir|
        project_file = File.join(dir, "nix")
        FileUtils.mkdir_p(project_file)
        File.write(File.join(project_file, "workspace.nix"), "{}\n")

        command = StubBuildNodeModules.new
        command.instance_variable_set(:@project, StubProject.new(dir))

        root = command.store_root
        command.create_source_marker("v1")

        result = command.send(:build_node_modules, "workspace")

        assert_equal root, result
        assert_equal 1, command.run_calls
        refute Dir.exist?(File.join(dir, "node_modules"))
        refute File.exist?(File.join(dir, ".onix_node_modules_id"))
      end
    end

    def test_build_env_includes_runtime_tls_and_token_vars
      Dir.mktmpdir do |dir|
        command = StubBuild.new
        command.instance_variable_set(:@project, StubProject.new(dir))
        with_clean_npm_token_env do
          ENV["NPM_TOKEN"] = "token-123"
          ENV["SSL_CERT_FILE"] = "/tmp/ca.pem"
          ENV["NODE_TLS_REJECT_UNAUTHORIZED"] = "0"

          env = command.send(:pnpm_build_env)

          assert_match "token-123", env["ONIX_NPM_TOKEN_LINES"]
          assert_equal "/tmp/ca.pem", env["SSL_CERT_FILE"]
          assert_equal "0", env["NODE_TLS_REJECT_UNAUTHORIZED"]
        end
      ensure
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

        with_clean_npm_token_env do
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
        end
      ensure
        ENV.delete("SSL_CERT_FILE")
      end
    end

    def test_run_nix_with_return_paths_uses_out_link_and_returns_realpath
      Dir.mktmpdir do |dir|
        command = StubRunNixBuild.new
        command.instance_variable_set(:@project, StubProject.new(dir))

        command.instance_variable_set(:@keep_going, false)
        workspace_nix = File.join(dir, "workspace.nix")
        File.write(workspace_nix, "{}\n")

        result = command.send(
          :run_nix,
          ["nix-build", "--no-out-link", "#{dir}/workspace.nix", "-A", "nodeModules"],
          return_paths: true,
        )
        direct = command.direct_calls.last

        assert result.start_with?(Dir.tmpdir)
        assert_kind_of String, result
        assert_equal direct[:out_link], command.instance_variable_get(:@direct_calls).last[:out_link]
        assert_includes direct[:command], "--out-link"
        refute_includes direct[:command], "--no-out-link"
        assert direct[:return_paths]
      end
    end

    def test_shellescape_escapes_special_chars_without_corrupting_output
      command = Onix::Commands::Build.new

      assert_equal "a\\ b", command.send(:shellescape, "a b")
      assert_equal "a\\$b", command.send(:shellescape, "a$b")
    end

    def test_sanitize_output_line_masks_registry_and_bearer_tokens
      command = Onix::Commands::Build.new
      masked = command.send(
        :sanitize_output_line,
        "//registry.npmjs.org/:_authToken=abc123 Authorization: Bearer topsecret _authToken=another-token"
      )

      refute_includes masked, "abc123"
      refute_includes masked, "topsecret"
      refute_includes masked, "another-token"
      assert_includes masked, "[REDACTED]"
    end

    def test_auth_failure_hint_for_node_modules_command
      command = Onix::Commands::Build.new
      hint = command.send(
        :auth_failure_hint_for,
        ["nix-build", "--no-out-link", "nix/workspace.nix", "-A", "nodeModules"],
        ["ERR_PNPM_FETCH_401 GET https://npm.pkg.github.com/foo Unauthorized"],
      )
      assert_includes hint, "Node registry authentication may be missing"
      assert_includes hint, "NPM_TOKEN"
    end

    def test_auth_failure_hint_skips_non_node_or_non_auth_errors
      command = Onix::Commands::Build.new
      assert_nil command.send(
        :auth_failure_hint_for,
        ["nix-build", "--no-out-link", "nix/workspace.nix", "-A", "bundlePath"],
        ["ERR_PNPM_FETCH_401 GET https://npm.pkg.github.com/foo Unauthorized"],
      )

      assert_nil command.send(
        :auth_failure_hint_for,
        ["nix-build", "--no-out-link", "nix/workspace.nix", "-A", "nodeModules"],
        ["builder for '/nix/store/foo.drv' failed with exit code 1"],
      )
    end

    def test_print_tail_redacts_tokens_in_stderr_output
      command = Onix::Commands::Build.new
      line = "E401 //registry.npmjs.org/:_authToken=supersecret Authorization: Bearer abc123\n"
      old_stderr = $stderr
      buffer = StringIO.new
      $stderr = buffer

      command.send(:print_tail, [line])
      rendered = buffer.string

      refute_includes rendered, "supersecret"
      refute_includes rendered, "abc123"
      assert_includes rendered, "_authToken=[REDACTED]"
      assert_includes rendered, "Authorization: Bearer [REDACTED]"
    ensure
      $stderr = old_stderr
    end
  end
end
