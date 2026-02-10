#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# libddwaf
#
# Versions: 1.14.0.0.0, 1.24.1.0.3, 1.25.1.0.1, 1.25.1.1.0, 1.30.0.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.30.0.0.0",
  git ? { },
}:
let
  versions = {
    "1.14.0.0.0" = import ./1.14.0.0.0 { inherit lib stdenv ruby; };
    "1.24.1.0.3" = import ./1.24.1.0.3 { inherit lib stdenv ruby; };
    "1.25.1.0.1" = import ./1.25.1.0.1 { inherit lib stdenv ruby; };
    "1.25.1.1.0" = import ./1.25.1.1.0 { inherit lib stdenv ruby; };
    "1.30.0.0.0" = import ./1.30.0.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "libddwaf: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "libddwaf: unknown version '${version}'")
