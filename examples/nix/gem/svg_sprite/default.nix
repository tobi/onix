#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# svg_sprite
#
# Versions: 1.0.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.3",
  git ? { },
}:
let
  versions = {
    "1.0.3" = import ./1.0.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "svg_sprite: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "svg_sprite: unknown version '${version}'")
