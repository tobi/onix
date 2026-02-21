# frozen_string_literal: true

require_relative "test_helper"
require "onix/pnpm/lockfile"

class PnpmLockfileParseTest < Minitest::Test
  def test_parses_simple_lockfile_v9
    lockfile = Onix::Pnpm::Lockfile.parse(fixture_path("pnpm", "simple", "pnpm-lock.yaml"))

    assert_equal "9.0", lockfile.lockfile_version
    assert_equal 1, lockfile.importers.size
    assert_equal 15, lockfile.packages.size
    assert_equal 15, lockfile.snapshots.size
  end

  def test_parses_workspace_link_dependency
    lockfile = Onix::Pnpm::Lockfile.parse(fixture_path("pnpm", "workspace", "pnpm-lock.yaml"))

    bar = lockfile.importers.fetch("bar")
    foo_dep = bar.dependencies.fetch("foo")

    assert_equal "link:../foo", foo_dep.version
  end

  def test_preserves_peer_suffix_variants
    lockfile = Onix::Pnpm::Lockfile.parse(fixture_path("pnpm", "peers", "pnpm-lock.yaml"))

    snapshot_key = "foo@1.0.0(bar@2.0.0)"
    snapshot = lockfile.snapshots.fetch(snapshot_key)

    assert_equal({ "bar" => "2.0.0" }, snapshot.dependencies)
  end

  def test_snapshot_for_resolves_peer_and_name_variants
    lockfile = Onix::Pnpm::Lockfile.parse(fixture_path("pnpm", "peers", "pnpm-lock.yaml"))
    snapshot = lockfile.snapshot_for("foo", "1.0.0(bar@2.0.0)")

    assert_equal({ "bar" => "2.0.0" }, snapshot.dependencies)
  end

  def test_snapshot_for_prefers_name_version_forms
    lockfile = Onix::Pnpm::Lockfile.parse(fixture_path("pnpm", "peers", "pnpm-lock.yaml"))

    assert_equal ["1.0.0(bar@2.0.0)", "1.0.0", "foo@1.0.0(bar@2.0.0)", "foo@1.0.0"].uniq,
      lockfile.canonical_snapshot_keys("foo", "1.0.0(bar@2.0.0)")
  end

  def test_snapshot_lookup_resolves_name_version_when_dep_version_is_plain
    lockfile_yaml = <<~YAML
      lockfileVersion: '9.0'
      importers:
        .:
          dependencies:
            "@scope/foo":
              specifier: ^2.0.0
              version: 2.0.0
      snapshots:
        "@scope/foo@2.0.0":
          dependencies:
            bar: 1.0.0
      packages: {}
    YAML

    Dir.mktmpdir do |dir|
      lockfile = File.join(dir, "pnpm-lock.yaml")
      File.write(lockfile, lockfile_yaml)
      parsed = Onix::Pnpm::Lockfile.parse(lockfile)
      dependency = parsed.importers.fetch(".").dependencies.fetch("@scope/foo")
      snapshot = parsed.snapshot_for("@scope/foo", dependency.version)
      assert_equal "@scope/foo@2.0.0", snapshot.key
      assert_equal({ "bar" => "1.0.0" }, snapshot.dependencies)
    end
  end

  def test_package_for_exposes_resolution_and_platform_constraints
    lockfile_yaml = <<~YAML
      lockfileVersion: '9.0'
      importers:
        .:
          dependencies:
            foo:
              specifier: ^1.0.0
              version: 1.0.0
      snapshots:
        foo@1.0.0: {}
      packages:
        foo@1.0.0:
          resolution:
            integrity: sha512-xyz
          os: [linux]
          cpu: [x64]
          libc: [glibc]
          engines:
            node: ">=20"
    YAML

    Dir.mktmpdir do |dir|
      lockfile = File.join(dir, "pnpm-lock.yaml")
      File.write(lockfile, lockfile_yaml)
      parsed = Onix::Pnpm::Lockfile.parse(lockfile)
      package = parsed.package_for("foo", "1.0.0")

      assert package
      assert_equal({ "integrity" => "sha512-xyz" }, package.resolution)
      assert_equal ["linux"], package.os
      assert_equal ["x64"], package.cpu
      assert_equal ["glibc"], package.libc
      assert_equal({ "node" => ">=20" }, package.engines)
    end
  end
end
