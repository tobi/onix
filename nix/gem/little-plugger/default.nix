#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# little-plugger
#
# Versions: 1.1.2, 1.1.4
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.1.4",
  git ? { },
}:
let
  versions = {
    "1.1.2" = import ./1.1.2 { inherit lib stdenv ruby; };
    "1.1.4" = import ./1.1.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "little-plugger: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "little-plugger: unknown version '${version}'")
