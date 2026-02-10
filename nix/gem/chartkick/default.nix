#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# chartkick
#
# Versions: 4.2.1, 5.2.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.2.1",
  git ? { },
}:
let
  versions = {
    "4.2.1" = import ./4.2.1 { inherit lib stdenv ruby; };
    "5.2.1" = import ./5.2.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "chartkick: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "chartkick: unknown version '${version}'")
