# libv8 — Tries to build V8 from source, requires python2 + depot_tools.
# These old versions (7.x, 8.x) are essentially unbuildable in a nix sandbox.
# Use libv8-node instead (which ships pre-built binaries).
# Skip the build entirely and produce an empty output.
{ pkgs, ruby, ... }:
{
  deps = [ ];
  buildPhase = ''
    echo "libv8: skipping build (use libv8-node instead)"
  '';
}
