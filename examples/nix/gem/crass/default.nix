#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# crass
#
# Versions: 1.0.4, 1.0.5, 1.0.6
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.6",
  git ? { },
}:
let
  versions = {
    "1.0.4" = import ./1.0.4 { inherit lib stdenv ruby; };
    "1.0.5" = import ./1.0.5 { inherit lib stdenv ruby; };
    "1.0.6" = import ./1.0.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "crass: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "crass: unknown version '${version}'")
