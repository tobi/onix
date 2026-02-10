#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop-performance
#
# Versions: 1.21.0, 1.24.0, 1.25.0, 1.26.0, 1.26.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.26.1",
  git ? { },
}:
let
  versions = {
    "1.21.0" = import ./1.21.0 { inherit lib stdenv ruby; };
    "1.24.0" = import ./1.24.0 { inherit lib stdenv ruby; };
    "1.25.0" = import ./1.25.0 { inherit lib stdenv ruby; };
    "1.26.0" = import ./1.26.0 { inherit lib stdenv ruby; };
    "1.26.1" = import ./1.26.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rubocop-performance: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rubocop-performance: unknown version '${version}'")
