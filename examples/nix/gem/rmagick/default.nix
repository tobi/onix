#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rmagick
#
# Versions: 6.1.3, 6.1.4, 6.1.5
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.1.5",
  git ? { },
}:
let
  versions = {
    "6.1.3" = import ./6.1.3 { inherit lib stdenv ruby pkgs; };
    "6.1.4" = import ./6.1.4 { inherit lib stdenv ruby pkgs; };
    "6.1.5" = import ./6.1.5 { inherit lib stdenv ruby pkgs; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rmagick: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rmagick: unknown version '${version}'")
