#!/usr/bin/env bash
# Shared test helpers for onix node test suites.
# Source this file at the top of each run-tests script.

setup_node() {
  NODEJS=$(nix-build --no-out-link '<nixpkgs>' -A nodejs_22 2>/dev/null)
  NODE="$NODEJS/bin/node"
}

require_pnpm() {
  local skip_msg="${1:-Tests require pnpm >= 10}"
  if ! command -v pnpm >/dev/null 2>&1; then
    echo ""
    echo "SKIP: pnpm not installed ($skip_msg)"
    return 1
  fi
  return 0
}

# Build packageDir for a project nix file and set PKG_DIR.
build_package_dir() {
  local nix_file="$1"
  PKG_DIR=$(nix-build --no-out-link "$nix_file" -A packageDir 2>/dev/null)
  if [ ! -d "$PKG_DIR" ]; then
    echo "FAIL: packageDir did not produce a directory"
    exit 1
  fi
}

# Run pnpm install with the custom fetcher.
# Usage: pnpm_install <pnpmfile_path>
# Requires PKG_DIR to be set (from build_package_dir).
pnpm_install() {
  local pnpmfile="$1"
  # pnpm copies files from the Nix store preserving read-only permissions,
  # so rm -rf alone can't remove a leftover node_modules/ from a previous run.
  chmod -R u+w node_modules 2>/dev/null || true
  rm -rf node_modules
  # --no-frozen-lockfile: pnpm v11+ writes a pnpmfileChecksum into the lockfile,
  # which changes whenever pnpmfile.cjs changes. Safe here since this is a test dir.
  ONIX_PACKAGE_DIR="$PKG_DIR" pnpm install --no-frozen-lockfile --ignore-scripts \
    --config.global-pnpmfile="$pnpmfile" 2>&1
  test -d node_modules/.pnpm || { echo "FAIL: .pnpm virtual store not created"; exit 1; }
}
