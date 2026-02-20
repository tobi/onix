# frozen_string_literal: true

require_relative "test_helper"
require_relative "../lib/onix/packageset"
require_relative "../lib/onix/project"
require_relative "../lib/onix/commands/generate"
require_relative "../lib/onix/commands/check"

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

    Progress = Class.new do
      def initialize(*)
      end

      def advance(*)
      end

      def finish
end
  end
end

class GenerateNodeTest < Minitest::Test
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

    def ruby_dir
      File.join(nix_dir, "ruby")
    end

    def node_dir
      File.join(nix_dir, "node")
    end

    def overlays_dir
      File.join(root, "overlays")
    end
  end

  def setup
    @command = Onix::Commands::Generate.new
    @checker = Onix::Commands::Check.new

    @command.singleton_class.prepend(Module.new do
      def prefetch_pnpm_deps_hash(*)
        "sha256-dummy"
      end
    end)
  end

  def test_generate_writes_node_derivations_with_deterministic_sorting
    Dir.mktmpdir do |dir|
      packagesets_dir = File.join(dir, "packagesets")
      FileUtils.mkdir_p(packagesets_dir)

      entries = [
        Onix::Packageset::Entry.new(
          installer: "node",
          name: "dup",
          version: "2.0.0",
          source: "pnpm",
          deps: ["glob"],
          groups: ["development"],
        ),
        Onix::Packageset::Entry.new(
          installer: "node",
          name: "dup",
          version: "1.0.0",
          source: "pnpm",
          deps: [],
        ),
        Onix::Packageset::Entry.new(
          installer: "node",
          name: "file-link",
          version: "0.1.0",
          source: "file",
          path: "vendor/file-link",
          deps: [],
        ),
      ].shuffle

      Onix::Packageset.write(
        File.join(packagesets_dir, "workspace.jsonl"),
        meta: Onix::Packageset::Meta.new(ruby: nil, bundler: nil, platforms: []),
        entries: entries
      )

      Dir.chdir(dir) do
        @command.run([])
      end

      node_dir = File.join(dir, "nix", "node")
      workspace_nix = File.join(dir, "nix", "workspace.nix")
      dup_nix = File.join(node_dir, "dup.nix")

      assert File.exist?(dup_nix), "expected node package file: #{dup_nix}"
      dup_contents = File.read(dup_nix)
      assert_operator dup_contents.index(%q("1.0.0" = {)), :<, dup_contents.index(%q("2.0.0" = {)),
                      "versions must be sorted ascending"
      assert_includes dup_contents, %(source = "pnpm";)

      assert File.exist?(workspace_nix), "expected project file: #{workspace_nix}"
      project_contents = File.read(workspace_nix)
      node_keys = project_contents.scan(/^\s+("[^"]+\/[^"]+") = \(nodeSpec /).flatten
      assert_equal ['"dup/1.0.0"', '"dup/2.0.0"', '"file-link/0.1.0"'], node_keys
      assert_includes project_contents, "nodeModules ="
      assert_includes project_contents, "projectRoot = ../.;"
    end
  end

  def test_generate_includes_workspace_paths_from_importers
    Dir.mktmpdir do |dir|
      packagesets_dir = File.join(dir, "packagesets")
      FileUtils.mkdir_p(packagesets_dir)

      Onix::Packageset.write(
        File.join(packagesets_dir, "workspace.jsonl"),
        meta: Onix::Packageset::Meta.new(ruby: nil, bundler: nil, platforms: []),
        entries: [
          Onix::Packageset::Entry.new(
            installer: "node",
            name: "react",
            version: "18.3.1",
            source: "pnpm",
            importer: "bar",
            deps: [],
          ),
          Onix::Packageset::Entry.new(
            installer: "node",
            name: "is-positive",
            version: "3.1.0",
            source: "pnpm",
            importer: "foo",
            deps: [],
          ),
        ]
      )

      Dir.chdir(dir) do
        @command.run([])
      end

      project_contents = File.read(File.join(dir, "nix", "workspace.nix"))
      assert_includes project_contents, 'workspacePaths = [ "bar" "foo" ];'
    end
  end

  def test_sort_versions_keeps_non_semver_in_input_order
    entries = [
      Onix::Packageset::Entry.new(installer: "node", name: "pkg", version: "file:../b", source: "file"),
      Onix::Packageset::Entry.new(installer: "node", name: "pkg", version: "2.0.0", source: "pnpm"),
      Onix::Packageset::Entry.new(installer: "node", name: "pkg", version: "link:../a", source: "link"),
      Onix::Packageset::Entry.new(installer: "node", name: "pkg", version: "1.0.0", source: "pnpm"),
    ]

    sorted = @command.send(:sort_versions, entries)
    assert_equal ["1.0.0", "2.0.0", "file:../b", "link:../a"], sorted.map(&:version)
  end

  def test_generate_creates_scoped_node_package_path
    Dir.mktmpdir do |dir|
      packagesets_dir = File.join(dir, "packagesets")
      FileUtils.mkdir_p(packagesets_dir)

      Onix::Packageset.write(
        File.join(packagesets_dir, "workspace.jsonl"),
        meta: Onix::Packageset::Meta.new(ruby: nil, bundler: nil, platforms: []),
        entries: [
          Onix::Packageset::Entry.new(
            installer: "node",
            name: "@scope/pkg",
            version: "1.2.3",
            source: "pnpm",
            deps: [],
          ),
        ]
      )

      Dir.chdir(dir) do
        @command.run([])
      end

      scoped_nix = File.join(dir, "nix", "node", "@scope", "pkg.nix")
      assert File.exist?(scoped_nix), "expected scoped node package path: #{scoped_nix}"
      assert_includes File.read(scoped_nix), %(version = "1.2.3";)
    end
  end

  def test_generate_uses_lockfile_directory_for_node_project_paths
    Dir.mktmpdir do |dir|
      packagesets_dir = File.join(dir, "packagesets")
      FileUtils.mkdir_p(packagesets_dir)
      workspace_dir = File.join(dir, "workspace")
      FileUtils.mkdir_p(workspace_dir)
      File.write(File.join(workspace_dir, "pnpm-lock.yaml"), "{\n}\n")

      entries = [
        Onix::Packageset::Entry.new(
          installer: "node",
          name: "pnpm-lock",
          version: "1.0.0",
          source: "pnpm",
          deps: ["glob"],
        )
      ]

      Onix::Packageset.write(
        File.join(packagesets_dir, "workspace.jsonl"),
        meta: Onix::Packageset::Meta.new(ruby: nil, bundler: nil, platforms: []),
        entries: entries
      )

      Dir.chdir(dir) do
        @command.run([])
      end

      project_contents = File.read(File.join(dir, "nix", "workspace.nix"))
      assert_includes project_contents, "projectRoot = ../workspace/.;"
      assert_includes project_contents, "lockfile = ../workspace/pnpm-lock.yaml;"
    end
  end

  def test_generate_uses_project_named_lockfile_when_present
    Dir.mktmpdir do |dir|
      packagesets_dir = File.join(dir, "packagesets")
      FileUtils.mkdir_p(packagesets_dir)
      lockfile = File.join(dir, "workspace.pnpm-lock.yaml")
      File.write(lockfile, "{\n}\n")

      entries = [
        Onix::Packageset::Entry.new(
          installer: "node",
          name: "pnpm-lock",
          version: "1.0.0",
          source: "pnpm",
          deps: ["glob"],
        )
      ]

      Onix::Packageset.write(
        File.join(packagesets_dir, "workspace.jsonl"),
        meta: Onix::Packageset::Meta.new(ruby: nil, bundler: nil, platforms: []),
        entries: entries
      )

      Dir.chdir(dir) do
        @command.run([])
      end

      project_contents = File.read(File.join(dir, "nix", "workspace.nix"))
      assert_includes project_contents, "projectRoot = ../.;"
      assert_includes project_contents, "lockfile = ../workspace.pnpm-lock.yaml;"
    end
  end

  def test_generate_uses_meta_lockfile_path_when_discovery_paths_are_missing
    Dir.mktmpdir do |dir|
      packagesets_dir = File.join(dir, "packagesets")
      FileUtils.mkdir_p(packagesets_dir)

      external = Dir.mktmpdir
      lockfile = File.join(external, "custom-lock.pnpm-lock.yaml")
      File.write(lockfile, "{\n}\n")

      entries = [
        Onix::Packageset::Entry.new(
          installer: "node",
          name: "pnpm-lock",
          version: "1.0.0",
          source: "pnpm",
          deps: ["glob"],
        )
      ]

      Onix::Packageset.write(
        File.join(packagesets_dir, "workspace.jsonl"),
        meta: Onix::Packageset::Meta.new(
          ruby: nil,
          bundler: nil,
          platforms: [],
          lockfile_path: lockfile,
        ),
        entries: entries
      )

      Dir.chdir(dir) do
        @command.run([])
      end

      project_contents = File.read(File.join(dir, "nix", "workspace.nix"))
      assert_includes project_contents, File.basename(lockfile)
    end
  end

  def test_generate_projects_include_pnpm_deps_hash
    Dir.mktmpdir do |dir|
      packagesets_dir = File.join(dir, "packagesets")
      FileUtils.mkdir_p(packagesets_dir)

      entries = [
        Onix::Packageset::Entry.new(
          installer: "node",
          name: "pnpm-lock",
          version: "1.0.0",
          source: "pnpm",
          deps: ["glob"],
        ),
      ]
      Onix::Packageset.write(
        File.join(packagesets_dir, "workspace.jsonl"),
        meta: Onix::Packageset::Meta.new(ruby: nil, bundler: nil, platforms: []),
        entries: entries
      )

      Dir.chdir(dir) do
        @command.run([])
      end

      project_contents = File.read(File.join(dir, "nix", "workspace.nix"))
      assert_includes project_contents, %(pnpmDepsHash = "sha256-dummy";)
      assert_includes project_contents, %(globalDepsKey = "lock=sha256-dummy;pnpm=0;node=0";)
    end
  end

  def test_generate_projects_include_node_and_pnpm_majors
    Dir.mktmpdir do |dir|
      packagesets_dir = File.join(dir, "packagesets")
      FileUtils.mkdir_p(packagesets_dir)

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
        File.join(packagesets_dir, "workspace.jsonl"),
        meta: Onix::Packageset::Meta.new(
          ruby: nil,
          bundler: nil,
          platforms: [],
          node_version_major: 22,
          pnpm_version_major: 10,
        ),
        entries: entries,
      )

      Dir.chdir(dir) do
        @command.run([])
      end

      project_contents = File.read(File.join(dir, "nix", "workspace.nix"))
      assert_includes project_contents, "nodeVersionMajor = 22;"
      assert_includes project_contents, "pnpmVersionMajor = 10;"
      assert_includes project_contents, %(globalDepsKey = "lock=sha256-dummy;pnpm=10;node=22";)
    end
  end


  def test_generate_keeps_installer_namespaces_for_similar_names
    Dir.mktmpdir do |dir|
      packagesets_dir = File.join(dir, "packagesets")
      FileUtils.mkdir_p(packagesets_dir)

      entries = [
        Onix::Packageset::Entry.new(
          installer: "ruby",
          name: "shared",
          version: "1.0.0",
          source: "rubygems",
          remote: "https://rubygems.org",
          deps: [],
        ),
        Onix::Packageset::Entry.new(
          installer: "node",
          name: "shared",
          version: "1.0.0",
          source: "pnpm",
          deps: [],
        ),
      ]

      Onix::Packageset.write(
        File.join(packagesets_dir, "both.jsonl"),
        meta: Onix::Packageset::Meta.new(ruby: nil, bundler: nil, platforms: []),
        entries: entries,
      )

      command = @command
      def command.nix_prefetch_url(_)
        "sha256-dummy"
      end

      Dir.chdir(dir) do
        @command.run([])
      end

      assert File.exist?(File.join(dir, "nix", "ruby", "shared.nix"))
      assert File.exist?(File.join(dir, "nix", "node", "shared.nix"))
    end
  end

  def test_check_reports_node_packages_as_complete_when_node_file_exists
    Dir.mktmpdir do |dir|
      packagesets_dir = File.join(dir, "packagesets")
      FileUtils.mkdir_p(packagesets_dir)
      node_nix_dir = File.join(dir, "nix", "node")
      FileUtils.mkdir_p(node_nix_dir)

      entries = [
        Onix::Packageset::Entry.new(
          installer: "node",
          name: "vite",
          version: "5.0.0",
          source: "pnpm",
          deps: ["esbuild"],
        )
      ]
      Onix::Packageset.write(
        File.join(packagesets_dir, "vite.jsonl"),
        meta: Onix::Packageset::Meta.new(ruby: nil, bundler: nil, platforms: []),
        entries: entries,
      )

      File.write(File.join(node_nix_dir, "vite.nix"), "# generated node file\n{}\n")

      @checker.instance_variable_set(:@project, StubProject.new(dir))
      ok, message = @checker.send(:check_packageset_complete)
      assert ok
      assert_equal "1 packages all have generated files", message
    end
  end

  def test_generate_respects_script_policy_and_cli_override
    Dir.mktmpdir do |dir|
      packagesets_dir = File.join(dir, "packagesets")
      FileUtils.mkdir_p(packagesets_dir)

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
        File.join(packagesets_dir, "vite.jsonl"),
        meta: Onix::Packageset::Meta.new(ruby: nil, bundler: nil, platforms: [], script_policy: "allowed"),
        entries: entries,
      )

      Dir.chdir(dir) do
        @command.run(["--scripts", "none"])
      end

      project_contents = File.read(File.join(dir, "nix", "vite.nix"))
      assert_includes project_contents, %(scriptPolicy = "none";)

      FileUtils.rm_rf(File.join(dir, "nix"))
      Dir.chdir(dir) do
        @command.run(["--scripts", "allowed"])
      end

      project_contents = File.read(File.join(dir, "nix", "vite.nix"))
      assert_includes project_contents, %(scriptPolicy = "allowed";)
    end
  end

  def test_generate_rejects_invalid_script_policy_override
    Dir.mktmpdir do |dir|
      packagesets_dir = File.join(dir, "packagesets")
      FileUtils.mkdir_p(packagesets_dir)

      Onix::Packageset.write(
        File.join(packagesets_dir, "vite.jsonl"),
        meta: Onix::Packageset::Meta.new(ruby: nil, bundler: nil, platforms: []),
        entries: [
          Onix::Packageset::Entry.new(
            installer: "node",
            name: "vite",
            version: "5.0.0",
            source: "pnpm",
            deps: ["esbuild"],
          ),
        ],
      )

      Dir.chdir(dir) do
        assert_raises(SystemExit) do
          @command.run(["--scripts", "all"])
        end
      end
    end
  end

  def test_generate_rejects_invalid_script_policy_meta_value
    Dir.mktmpdir do |dir|
      packagesets_dir = File.join(dir, "packagesets")
      FileUtils.mkdir_p(packagesets_dir)

      Onix::Packageset.write(
        File.join(packagesets_dir, "vite.jsonl"),
        meta: Onix::Packageset::Meta.new(
          ruby: nil,
          bundler: nil,
          platforms: [],
          package_manager: "pnpm@10.0.0",
          script_policy: "all",
        ),
        entries: [
          Onix::Packageset::Entry.new(
            installer: "node",
            name: "vite",
            version: "5.0.0",
            source: "pnpm",
            deps: ["esbuild"],
          ),
        ],
      )

      assert_raises(SystemExit) do
        Dir.chdir(dir) do
          @command.run([])
        end
      end
    end
  end

  def test_generated_artifacts_do_not_contain_registry_tokens
    Dir.mktmpdir do |dir|
      packagesets_dir = File.join(dir, "packagesets")
      FileUtils.mkdir_p(packagesets_dir)

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
        File.join(packagesets_dir, "vite.jsonl"),
        meta: Onix::Packageset::Meta.new(
          ruby: nil,
          bundler: nil,
          platforms: [],
          package_manager: "pnpm@10.0.0",
          script_policy: "allowed",
        ),
        entries: entries
      )

      with_token = ENV["NPM_TOKEN"]
      ENV["NPM_TOKEN"] = "secret-token"
      Dir.chdir(dir) do
        @command.run([])
      end
      ENV["NPM_TOKEN"] = with_token

      contents = File.read(File.join(dir, "nix", "vite.nix"))
      refute_includes contents, "secret-token"
      refute_includes contents, "NPM_TOKEN"
    ensure
      ENV["NPM_TOKEN"] = with_token
    end
  end

  def test_generated_node_builder_has_non_offline_install_command
    Dir.mktmpdir do |dir|
      packagesets_dir = File.join(dir, "packagesets")
      FileUtils.mkdir_p(packagesets_dir)

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
        File.join(packagesets_dir, "vite.jsonl"),
        meta: Onix::Packageset::Meta.new(
          ruby: nil,
          bundler: nil,
          platforms: [],
          package_manager: "pnpm@10.0.0",
          script_policy: "allowed",
        ),
        entries: entries,
      )

      Dir.chdir(dir) do
        @command.run([])
      end

      build_nix = File.read(File.join(dir, "nix", "build-node-modules.nix"))
      assert_includes build_nix, "pnpm config set manage-package-manager-versions false"
      assert_includes build_nix, "pnpm config set engine-strict true"
      assert_includes build_nix, "pnpm = pnpmPackage;"
      assert_includes build_nix, "pkgs.pnpm_9 or pkgs.pnpm"
      refute_includes build_nix, "--offline"
      refute_includes build_nix, "delete p.packageManager"
      refute_includes build_nix, "delete p.engines.pnpm"
      assert_includes build_nix, "pnpm install --force"

      project_nix = File.read(File.join(dir, "nix", "vite.nix"))
      assert_includes project_nix, "scriptPolicy = \"allowed\";"
    end
  end

  def test_generate_wires_node_overlays_via_node_config
    Dir.mktmpdir do |dir|
      packagesets_dir = File.join(dir, "packagesets")
      FileUtils.mkdir_p(packagesets_dir)
      overlays_dir = File.join(dir, "overlays", "node")
      FileUtils.mkdir_p(overlays_dir)

      Onix::Packageset.write(
        File.join(packagesets_dir, "vite.jsonl"),
        meta: Onix::Packageset::Meta.new(
          ruby: nil,
          bundler: nil,
          platforms: [],
          script_policy: "allowed",
        ),
        entries: [
          Onix::Packageset::Entry.new(
            installer: "node",
            name: "vite",
            version: "5.0.0",
            source: "pnpm",
            deps: ["esbuild"],
          ),
        ],
      )

      File.write(
        File.join(overlays_dir, "vite.nix"),
        <<~NIX
          { pkgs }:
          {
            deps = [ pkgs.python3 ];
            preBuild = "echo preBuild from overlay";
            installFlags = [ "--link-workspace-packages=false" ];
          }
        NIX
      )

      Dir.chdir(dir) do
        @command.run([])
      end

      project_contents = File.read(File.join(dir, "nix", "vite.nix"))
      assert_includes project_contents, "overlayDir = ../overlays/node;"
      assert_includes project_contents, "nodeConfig = import ./node-config.nix {"
      assert_includes project_contents, "inherit nodeConfig;"

      build_nix = File.read(File.join(dir, "nix", "build-node-modules.nix"))
      assert_match(/nodeConfig\s*\?\s*\{\s*\}/, build_nix)
      assert_includes build_nix, "nodeOverlayDeps"
      assert_includes build_nix, "nodePreBuild"
      assert_includes build_nix, "nodeInstallFlags"
      assert_includes build_nix, "preBuild = nodePreBuild;"
    end
  end

  def test_node_overlay_loader_rejects_legacy_keys
    node_config_nix = File.read(File.join(__dir__, "..", "lib", "onix", "data", "node-config.nix"))

    assert_includes node_config_nix, "deprecated key(s)"
    assert_includes node_config_nix, "preInstall"
    assert_includes node_config_nix, "prePnpmInstall"
    assert_includes node_config_nix, "pnpmInstallFlags"
    assert_includes node_config_nix, "if detectedOld != [ ] then"
    refute_includes node_config_nix, "_ ="
    refute_includes node_config_nix, "__ ="
  end

  def test_generate_infers_node_build_config_for_known_packages
    Dir.mktmpdir do |dir|
      packagesets_dir = File.join(dir, "packagesets")
      FileUtils.mkdir_p(packagesets_dir)

      entries = [
        Onix::Packageset::Entry.new(
          installer: "node",
          name: "node-sass",
          version: "10.0.0",
          source: "pnpm",
          deps: ["chalk"],
        ),
      ]
      Onix::Packageset.write(
        File.join(packagesets_dir, "workspace.jsonl"),
        meta: Onix::Packageset::Meta.new(
          ruby: nil,
          bundler: nil,
          platforms: [],
        ),
        entries: entries,
      )

      Dir.chdir(dir) do
        @command.run([])
      end

      node_nix = File.read(File.join(dir, "nix", "node", "node-sass.nix"))
      assert_includes node_nix, "buildConfig = {"
      assert_includes node_nix, "deps = [ pkgs.python3 ];"
    end
  end

  def test_generated_node_build_config_merges_with_node_overlay
    Dir.mktmpdir do |dir|
      packagesets_dir = File.join(dir, "packagesets")
      FileUtils.mkdir_p(packagesets_dir)
      overlays_dir = File.join(dir, "overlays", "node")
      FileUtils.mkdir_p(overlays_dir)

      entries = [
        Onix::Packageset::Entry.new(
          installer: "node",
          name: "grpc",
          version: "1.24.0",
          source: "pnpm",
          deps: ["chalk"],
        ),
      ]
      Onix::Packageset.write(
        File.join(packagesets_dir, "workspace.jsonl"),
        meta: Onix::Packageset::Meta.new(
          ruby: nil,
          bundler: nil,
          platforms: [],
        ),
        entries: entries,
      )

      File.write(
        File.join(overlays_dir, "grpc.nix"),
        <<~NIX
          { pkgs }:
          {
            deps = [ pkgs.gzip ];
            preBuild = "echo ONIX_NODE_OVERLAY_GRPC=1";
          }
        NIX
      )

      Dir.chdir(dir) do
        @command.run([])
      end

      node_nix = File.read(File.join(dir, "nix", "node", "grpc.nix"))
      assert_includes node_nix, "buildConfig = {"
      assert_includes node_nix, "pkgs.python3"
      assert_includes node_nix, %(pkgs."pkg-config")
      assert_includes node_nix, "ONIX_NODE_INFERRED_GRPC_BUILD=1"

      build_node_modules = File.read(File.join(dir, "nix", "build-node-modules.nix"))
      assert_match(/nodeConfigFromBuild\s*=\s*base:\s*overrides:/, build_node_modules)
      assert_includes build_node_modules, "inferredNodeConfigs"
      assert_includes build_node_modules, "nodeConfigPairs"
      assert_match(/override\s*=\s*nodeConfig\.\$\{name\}\s*or\s*\{\s*\}/, build_node_modules)
      assert_match(/if\s+inferred\s*==\s*\{\s*\}\s+then\s+override\s+else/, build_node_modules)
    end
  end


  def test_build_node_modules_copy_is_constrained_to_project_root
    build_node_modules_nix = File.read(File.join(__dir__, "..", "lib", "onix", "data", "build-node-modules.nix"))

    assert_includes build_node_modules_nix, "cleanSourceWith"
    assert_includes build_node_modules_nix, "ignoredSourcePrefixes"
    assert_includes build_node_modules_nix, "node_modules"
    assert_includes build_node_modules_nix, ".node_modules_id"
    assert_includes build_node_modules_nix, 'abs_path="$(cd "$PWD/$rel" 2>/dev/null && pwd)"'
    assert_includes build_node_modules_nix, "case \"$abs_path\" in"
    assert_includes build_node_modules_nix, "Skipping workspace path outside project root: $rel"
  end

  def test_sort_versions_uses_stable_fallback_for_non_semver_versions
    versions = [
      Onix::Packageset::Entry.new(installer: "node", name: "foo", version: "abc", source: "pnpm"),
      Onix::Packageset::Entry.new(installer: "node", name: "foo", version: "1.0.0", source: "pnpm"),
      Onix::Packageset::Entry.new(installer: "node", name: "foo", version: "02", source: "pnpm"),
    ].shuffle

    sorted = @command.send(:sort_versions, versions)
    version_order = sorted.map(&:version)

    assert_equal %w[1.0.0 02 abc], version_order
  end

  def test_extract_pnpm_fetch_hash_from_nix_output
    out = <<~OUTPUT
      warning: ignoring configure script in ...
      error: hash mismatch in fixed-output derivation '/nix/store/...':
      wanted: sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
      got: sha256-bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb=
    OUTPUT

    hash = @command.send(:extract_pnpm_fetch_hash, out)
    assert_equal "sha256-bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb=", hash
  end

  def test_prefetch_pnpm_deps_hash_returns_nil_when_lockfile_missing
    command = Onix::Commands::Generate.new
    assert_nil command.send(:prefetch_pnpm_deps_hash, "missing", nil)
  end

  def test_prefetch_pnpm_deps_hash_parses_hash_from_nix_output
    command = Onix::Commands::Generate.new
    Dir.mktmpdir do |dir|
      lockfile = File.join(dir, "pnpm-lock.yaml")
      File.write(lockfile, "lockfileVersion: '9.0'\n")

      command.define_singleton_method(:find_pnpm_lockfile) { |_| lockfile }

      Open3.stub(:capture3, ->(*) do
        [
          "",
          "error: hash mismatch: wanted: sha256-AAAAAAAA... got: sha256-bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb=\n",
          Struct.new(:success?).new(false),
        ]
      end) do
        result = command.send(:prefetch_pnpm_deps_hash, "workspace", nil)
        assert_equal "sha256-bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb=", result
      end
    end
  end

  def test_pnpm_prefetch_env_forwards_tls_values_and_tokens
    Dir.mktmpdir do |dir|
      lockfile = File.join(dir, "pnpm-lock.yaml")
      File.write(lockfile, "lockfileVersion: '9.0'\n")

      command = Onix::Commands::Generate.new
      command.instance_variable_set(:@project, Struct.new(:root).new(dir))

      token = ENV["NPM_TOKEN"]
      ENV["NPM_TOKEN"] = "token"
      ENV["SSL_CERT_FILE"] = "/tmp/ca.pem"
      ENV["NODE_EXTRA_CA_CERTS"] = "/tmp/node-extra-ca.pem"

      env = command.send(:pnpm_prefetch_env, lockfile)
      assert_equal "/tmp/ca.pem", env["SSL_CERT_FILE"]
      assert_equal "/tmp/node-extra-ca.pem", env["NODE_EXTRA_CA_CERTS"]
      assert_includes(env["ONIX_NPM_TOKEN_LINES"], "token")
    ensure
      ENV["NPM_TOKEN"] = token
      ENV.delete("SSL_CERT_FILE")
      ENV.delete("NODE_EXTRA_CA_CERTS")
    end
  end

  def test_pnpm_prefetch_npmrc_expr_sets_ca_defaults
    output = @command.send(:pnpm_prefetch_npmrc_expr)

    assert_includes output, "SSL_CERT_FILE"
    assert_includes output, "NODE_EXTRA_CA_CERTS"
    assert_includes output, "NPM_CONFIG_CAFILE"
    assert_includes output, "ONIX_NPM_TOKEN_LINES"
    refute_includes output, "${pkgs.nodejs}/bin/node -e"
    refute_includes output, "delete p.packageManager"
    refute_includes output, "delete p.engines.pnpm"
  end

  def test_prefetch_pnpm_deps_expr_normalizes_nonstandard_lockfile_name
    command = Onix::Commands::Generate.new
    expr = command.send(:prefetch_pnpm_deps_expr, "/tmp/workspace.pnpm-lock.yaml")

    assert_includes expr, "lockfilePath = /tmp/workspace.pnpm-lock.yaml;"
    assert_includes expr, 'builtins.baseNameOf lockfilePath == "pnpm-lock.yaml"'
    assert_includes expr, 'cp ${lockfilePath} "$out/pnpm-lock.yaml"'
    assert_includes expr, "pnpm config set manage-package-manager-versions false"
    assert_includes expr, "pnpm config set engine-strict true"
    assert_includes expr, "src = prefetchSrc;"
    assert_includes expr, "pnpm = pnpmPackage;"
    assert_includes expr, "pnpmMajor = null;"
  end

  def test_prefetch_pnpm_deps_expr_uses_major_specific_pnpm_package
    command = Onix::Commands::Generate.new
    meta = Onix::Packageset::Meta.new(
      ruby: nil,
      bundler: nil,
      platforms: [],
      pnpm_version_major: 9,
    )
    expr = command.send(:prefetch_pnpm_deps_expr, "/tmp/pnpm-lock.yaml", meta)

    assert_includes expr, "pnpmMajor = 9;"
    assert_includes expr, "else if pnpmMajor == 9 then pkgs.pnpm_9 or pkgs.pnpm"
    assert_includes expr, "pnpm = pnpmPackage;"
  end

  def test_build_node_modules_template_normalizes_nonstandard_lockfile_name
    build_node_modules_nix = File.read(File.join(__dir__, "..", "lib", "onix", "data", "build-node-modules.nix"))

    assert_includes build_node_modules_nix, "normalizedSourceRoot"
    assert_includes build_node_modules_nix, 'builtins.baseNameOf (toString lockfile)'
    assert_includes build_node_modules_nix, 'cp ${lockfile} "$out/pnpm-lock.yaml"'
    refute_includes build_node_modules_nix, 'cp "${toString lockfile}" pnpm-lock.yaml'
    assert_includes build_node_modules_nix, "src = normalizedSourceRoot;"
    assert_includes build_node_modules_nix, "onix-pnpm-deps-node${toString nodeMajor}-pnpm${toString pnpmMajor}"
    refute_includes build_node_modules_nix, "onix-${safeProject}-pnpm-deps"
    assert_includes build_node_modules_nix, "artifactIdentity"
    assert_includes build_node_modules_nix, "pnpmPackage ="
    assert_includes build_node_modules_nix, "pkgs.pnpm_9 or pkgs.pnpm"
    assert_includes build_node_modules_nix, "pnpm = pnpmPackage;"
    assert_includes build_node_modules_nix, "pnpm config set engine-strict true"
    refute_includes build_node_modules_nix, "pnpm config set engine-strict false"
    refute_includes build_node_modules_nix, "delete p.packageManager"
  end
end
end
