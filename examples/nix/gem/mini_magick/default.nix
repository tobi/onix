#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mini_magick
#
# Versions: 4.12.0, 4.13.2, 5.2.0, 5.3.0, 5.3.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.3.1",
  git ? { },
}:
let
  versions = {
    "4.12.0" = import ./4.12.0 { inherit lib stdenv ruby; };
    "4.13.2" = import ./4.13.2 { inherit lib stdenv ruby; };
    "5.2.0" = import ./5.2.0 { inherit lib stdenv ruby; };
    "5.3.0" = import ./5.3.0 { inherit lib stdenv ruby; };
    "5.3.1" = import ./5.3.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mini_magick: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "mini_magick: unknown version '${version}'")
