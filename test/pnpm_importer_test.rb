# frozen_string_literal: true

require_relative "test_helper"
require_relative "../lib/onix/commands/import"

module Onix
  module UI
    class << self
      def header(*) ; end
      def info(*) ; end
      def warn(*) ; end
      def wrote(*) ; end
      def done(*) ; end
      def bold(v) ; v ; end
    end
  end
end

class PnpmImporterTest < Minitest::Test
  def setup
    @command = Onix::Commands::Import.new
  end

  def test_detects_ruby_lockfile_automatically
    Dir.mktmpdir do |dir|
      File.write(File.join(dir, "Gemfile.lock"), "GEM\n  remote: https://rubygems.org/\n  specs:\nPLATFORMS\n  ruby\nDEPENDENCIES\n")
      File.write(File.join(dir, "package.json"), "{}\n")

      lockfile, project_name, installer = @command.send(:resolve_lockfile, dir, nil, nil)

      assert_equal "ruby", installer
      assert_equal File.join(dir, "Gemfile.lock"), lockfile
      assert_equal File.basename(dir), project_name
    end
  end

  def test_detects_pnpm_lockfile_automatically
    Dir.mktmpdir do |dir|
      File.write(File.join(dir, "pnpm-lock.yaml"), "lockfileVersion: '9.0'\n")
      File.write(File.join(dir, "package.json"), "{}\n")

      lockfile, project_name, installer = @command.send(:resolve_lockfile, dir, nil, nil)

      assert_equal "pnpm", installer
      assert_equal File.join(dir, "pnpm-lock.yaml"), lockfile
      assert_equal File.basename(dir), project_name
    end
  end

  def test_detects_nonstandard_pnpm_lockfile_automatically
    Dir.mktmpdir do |dir|
      File.write(File.join(dir, "custom.pnpm-lock.yaml"), "lockfileVersion: '9.0'\n")
      File.write(File.join(dir, "package.json"), "{}\n")

      lockfile, project_name, installer = @command.send(:resolve_lockfile, dir, nil, nil)

      assert_equal "pnpm", installer
      assert_equal File.join(dir, "custom.pnpm-lock.yaml"), lockfile
      assert_equal File.basename(dir), project_name
    end
  end

  def test_resolve_lockfile_accepts_custom_pnpm_lockfile_path
    Dir.mktmpdir do |dir|
      lockfile = File.join(dir, "custom.pnpm-lock.yaml")
      File.write(lockfile, "lockfileVersion: '9.0'\n")
      File.write(File.join(dir, "package.json"), "{}\n")

      resolved, project_name, installer = @command.send(:resolve_lockfile, lockfile, nil, nil)

      assert_equal "pnpm", installer
      assert_equal lockfile, resolved
      assert_equal File.basename(dir), project_name
    end
  end

  def test_resolve_lockfile_accepts_standard_pnpm_lockfile_path
    Dir.mktmpdir do |dir|
      lockfile = File.join(dir, "pnpm-lock.yaml")
      File.write(lockfile, "lockfileVersion: '9.0'\n")
      File.write(File.join(dir, "package.json"), "{}\n")

      resolved, project_name, installer = @command.send(:resolve_lockfile, lockfile, nil, nil)

      assert_equal "pnpm", installer
      assert_equal lockfile, resolved
      assert_equal File.basename(dir), project_name
    end
  end

  def test_imports_pnpm_workspace_with_multiple_importers_without_root
    Dir.mktmpdir do |dir|
      File.write(File.join(dir, "pnpm-lock.yaml"), File.read(fixture_path("pnpm", "workspace", "pnpm-lock.yaml")))
      File.write(File.join(dir, "package.json"), "{}\n")

      @command.instance_variable_set(:@project, stub_project(dir))

      @command.send(:import_pnpm, File.join(dir, "pnpm-lock.yaml"), "workspace")

      packageset = File.join(dir, "packagesets", "workspace.jsonl")
      assert File.exist?(packageset)

      _meta, entries = Onix::Packageset.read(packageset)
      assert entries.any? { |entry| entry.importer == "bar" && entry.name == "is-positive" }
      assert entries.any? { |entry| entry.importer == "foo" && entry.name == "is-negative" }
      assert entries.any? { |entry| entry.source == "link" && entry.version.start_with?("link:") }
    end
  end

  def test_resolve_lockfile_rejects_installer_override_mismatch
    Dir.mktmpdir do |dir|
      File.write(File.join(dir, "pnpm-lock.yaml"), "lockfileVersion: '9.0'\n")

      assert_raises(SystemExit) do
        @command.send(:resolve_lockfile, dir, nil, "ruby")
      end
    end
  end

  def test_rejects_multiple_directory_pnpm_lockfiles
    Dir.mktmpdir do |dir|
      File.write(File.join(dir, "alpha.pnpm-lock.yaml"), "lockfileVersion: '9.0'\n")
      File.write(File.join(dir, "beta.pnpm-lock.yaml"), "lockfileVersion: '9.0'\n")
      File.write(File.join(dir, "package.json"), "{}\n")

      assert_raises(SystemExit) do
        @command.send(:resolve_lockfile, dir, nil, nil)
      end
    end
  end

  def test_importing_pnpm_root_succeeds_with_dot_importer
    Dir.mktmpdir do |dir|
      File.write(File.join(dir, "pnpm-lock.yaml"), File.read(fixture_path("pnpm", "simple", "pnpm-lock.yaml")))
      File.write(File.join(dir, "package.json"), "{}\n")

      @command.instance_variable_set(:@project, stub_project(dir))

      @command.send(:import_pnpm, File.join(dir, "pnpm-lock.yaml"), "simple")

      packageset = File.join(dir, "packagesets", "simple.jsonl")
      assert File.exist?(packageset)

      meta, entries = Onix::Packageset.read(packageset)
      assert_equal 15, entries.count { |e| e.installer == "node" }
      assert_equal 15, entries.length
      assert entries.all? { |entry| entry.source == "pnpm" }, entries.map(&:source).uniq.inspect
      assert_equal File.join(dir, "pnpm-lock.yaml"), meta.lockfile_path
      assert entries.all? { |entry| entry.importer == "." }
    end
  end

  def test_import_rejects_older_pnpm_manager_than_lockfile
    Dir.mktmpdir do |dir|
      File.write(File.join(dir, "pnpm-lock.yaml"), File.read(fixture_path("pnpm", "simple", "pnpm-lock.yaml")))
      File.write(File.join(dir, "package.json"), '{ "packageManager": "pnpm@8.0.0" }')

      @command.instance_variable_set(:@project, stub_project(dir))

      assert_raises(ArgumentError) do
        @command.send(:import_pnpm, File.join(dir, "pnpm-lock.yaml"), "simple")
      end
    end
  end

  def test_import_rejects_non_exact_engines_pnpm_constraint
    Dir.mktmpdir do |dir|
      File.write(File.join(dir, "pnpm-lock.yaml"), File.read(fixture_path("pnpm", "simple", "pnpm-lock.yaml")))
      File.write(
        File.join(dir, "package.json"),
        '{ "packageManager": "pnpm@9.0.0", "engines": { "pnpm": ">=9" } }'
      )

      @command.instance_variable_set(:@project, stub_project(dir))

      error = assert_raises(ArgumentError) do
        @command.send(:import_pnpm, File.join(dir, "pnpm-lock.yaml"), "simple")
      end
      assert_includes error.message, "must pin an exact version"
    end
  end

  def test_import_rejects_mismatched_package_manager_and_engines_pnpm
    Dir.mktmpdir do |dir|
      File.write(File.join(dir, "pnpm-lock.yaml"), File.read(fixture_path("pnpm", "simple", "pnpm-lock.yaml")))
      File.write(
        File.join(dir, "package.json"),
        '{ "packageManager": "pnpm@10.28.0", "engines": { "pnpm": "9.6.0" } }'
      )

      @command.instance_variable_set(:@project, stub_project(dir))

      error = assert_raises(ArgumentError) do
        @command.send(:import_pnpm, File.join(dir, "pnpm-lock.yaml"), "simple")
      end
      assert_includes error.message, "engines.pnpm"
      assert_includes error.message, "packageManager"
    end
  end

  def test_import_allows_same_major_patch_drift_with_explicit_flag
    Dir.mktmpdir do |dir|
      File.write(File.join(dir, "pnpm-lock.yaml"), File.read(fixture_path("pnpm", "simple", "pnpm-lock.yaml")))
      File.write(
        File.join(dir, "package.json"),
        '{ "packageManager": "pnpm@9.15.9", "engines": { "pnpm": "9.6.0" } }'
      )

      warnings = []
      Onix::UI.stub(:warn, ->(msg) { warnings << msg }) do
        Dir.chdir(dir) do
          @command.run(["--installer", "pnpm", "--allow-pnpm-patch-drift", "."])
        end
      end

      packageset = File.join(dir, "packagesets", "#{File.basename(dir)}.jsonl")
      assert File.exist?(packageset)
      meta, entries = Onix::Packageset.read(packageset)
      assert_equal "pnpm@9.15.9", meta.package_manager
      assert_equal 9, meta.pnpm_version_major
      assert entries.any? { |entry| entry.installer == "node" }
      assert_equal 1, warnings.length
      assert_includes warnings.first, "--allow-pnpm-patch-drift"
      assert_includes warnings.first, "engines.pnpm 9.6.0"
      assert_includes warnings.first, "pnpm@9.15.9"
    end
  end

  def test_import_flag_does_not_allow_major_mismatch
    Dir.mktmpdir do |dir|
      File.write(File.join(dir, "pnpm-lock.yaml"), File.read(fixture_path("pnpm", "simple", "pnpm-lock.yaml")))
      File.write(
        File.join(dir, "package.json"),
        '{ "packageManager": "pnpm@10.28.0", "engines": { "pnpm": "9.6.0" } }'
      )

      error = assert_raises(ArgumentError) do
        Dir.chdir(dir) do
          @command.run(["--installer", "pnpm", "--allow-pnpm-patch-drift", "."])
        end
      end
      assert_includes error.message, "engines.pnpm"
      assert_includes error.message, "packageManager"
    end
  end

  def test_import_resolves_peer_variant_snapshots
    Dir.mktmpdir do |dir|
      File.write(File.join(dir, "pnpm-lock.yaml"), File.read(fixture_path("pnpm", "peers", "pnpm-lock.yaml")))
      File.write(File.join(dir, "package.json"), "{}\n")

      @command.instance_variable_set(:@project, stub_project(dir))

      @command.send(:import_pnpm, File.join(dir, "pnpm-lock.yaml"), "peers")

      packageset = File.join(dir, "packagesets", "peers.jsonl")
      _meta, entries = Onix::Packageset.read(packageset)
      foo = entries.find { |entry| entry.name == "foo" }

      assert foo
      assert_includes foo.deps, "bar"
      assert_equal "1.0.0(bar@2.0.0)", foo.version
    end
  end

  def test_import_resolves_name_version_snapshot_key
    Dir.mktmpdir do |dir|
      lockfile = File.join(dir, "pnpm-lock.yaml")
      File.write(lockfile, File.read(fixture_path("pnpm", "scope-name", "pnpm-lock.yaml")))
      File.write(File.join(dir, "package.json"), "{}\n")

      @command.instance_variable_set(:@project, stub_project(dir))
      @command.send(:import_pnpm, lockfile, "workspace")

      packageset = File.join(dir, "packagesets", "workspace.jsonl")
      _meta, entries = Onix::Packageset.read(packageset)
      scoped = entries.find { |entry| entry.name == "@scope/foo" }

      assert scoped
      assert_equal "2.0.0", scoped.version
      assert_includes scoped.deps, "bar"
      assert_equal "pnpm", scoped.source
      assert_equal ["default"], scoped.groups
    end
  end

  def test_import_stores_workspace_script_policy
    Dir.mktmpdir do |dir|
      File.write(File.join(dir, "pnpm-lock.yaml"), File.read(fixture_path("pnpm", "simple", "pnpm-lock.yaml")))
      File.write(File.join(dir, "package.json"), '{ "packageManager": "pnpm@10.0.0" }')
      File.write(File.join(dir, "pnpm-workspace.yaml"), <<~YAML)
        packages:
          - "."
        onlyBuiltDependencies:
          - something
      YAML

      @command.instance_variable_set(:@project, stub_project(dir))

      @command.send(:import_pnpm, File.join(dir, "pnpm-lock.yaml"), "simple")

      packageset = File.join(dir, "packagesets", "simple.jsonl")
      meta, entries = Onix::Packageset.read(packageset)
      assert_equal 15, entries.count { |entry| entry.installer == "node" }
      assert_equal 15, entries.size
      assert_equal "allowed", meta.script_policy
      assert_equal "pnpm@10.0.0", meta.package_manager
      assert_equal 10, meta.pnpm_version_major
    end
  end

  def test_import_uses_lockfile_major_when_package_manager_is_not_set
    Dir.mktmpdir do |dir|
      File.write(File.join(dir, "pnpm-lock.yaml"), File.read(fixture_path("pnpm", "simple", "pnpm-lock.yaml")))
      File.write(File.join(dir, "package.json"), '{ "name": "simple" }')

      @command.instance_variable_set(:@project, stub_project(dir))
      @command.send(:import_pnpm, File.join(dir, "pnpm-lock.yaml"), "simple")

      packageset = File.join(dir, "packagesets", "simple.jsonl")
      meta, = Onix::Packageset.read(packageset)
      assert_equal 9, meta.pnpm_version_major
    end
  end

  def test_import_prefers_exact_engines_pnpm_major_for_metadata
    Dir.mktmpdir do |dir|
      File.write(File.join(dir, "pnpm-lock.yaml"), File.read(fixture_path("pnpm", "simple", "pnpm-lock.yaml")))
      File.write(
        File.join(dir, "package.json"),
        '{ "packageManager": "pnpm@9.6.0", "engines": { "pnpm": "9.6.0" } }'
      )

      @command.instance_variable_set(:@project, stub_project(dir))
      @command.send(:import_pnpm, File.join(dir, "pnpm-lock.yaml"), "simple")

      packageset = File.join(dir, "packagesets", "simple.jsonl")
      meta, = Onix::Packageset.read(packageset)
      assert_equal 9, meta.pnpm_version_major
    end
  end

  def test_import_captures_integrity_resolution_and_engines
    Dir.mktmpdir do |dir|
      File.write(File.join(dir, "pnpm-lock.yaml"), File.read(fixture_path("pnpm", "workspace", "pnpm-lock.yaml")))
      File.write(File.join(dir, "package.json"), '{ "packageManager": "pnpm@10.0.0", "engines": { "node": ">=22.0.0" } }')

      @command.instance_variable_set(:@project, stub_project(dir))
      @command.send(:import_pnpm, File.join(dir, "pnpm-lock.yaml"), "workspace")

      packageset = File.join(dir, "packagesets", "workspace.jsonl")
      meta, entries = Onix::Packageset.read(packageset)
      positive = entries.find { |entry| entry.name == "is-positive" && entry.version == "1.0.0" }

      assert positive
      assert_equal "sha1-iACYVrZKLx632LsBeUGEJK4EUss=", positive.integrity
      assert_equal({ "integrity" => "sha1-iACYVrZKLx632LsBeUGEJK4EUss=" }, positive.resolution)
      assert_equal({ "node" => ">=0.10.0" }, positive.engines)
      assert_equal 22, meta.node_version_major
      assert_equal 10, meta.pnpm_version_major
    end
  end

  private

  def stub_project(dir)
    path = File.join(dir, "packagesets")
    Struct.new(:packagesets_dir).new(path)
  end
end
