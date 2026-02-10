#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# chunky_png
#
# Versions: 1.3.14, 1.3.15, 1.4.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.4.0",
  git ? { },
}:
let
  versions = {
    "1.3.14" = import ./1.3.14 { inherit lib stdenv ruby; };
    "1.3.15" = import ./1.3.15 { inherit lib stdenv ruby; };
    "1.4.0" = import ./1.4.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "chunky_png: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "chunky_png: unknown version '${version}'")
