#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# debase
#
# Versions: 0.2.7, 0.2.8, 0.2.9
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.2.9",
  git ? { },
}:
let
  versions = {
    "0.2.7" = import ./0.2.7 { inherit lib stdenv ruby pkgs; };
    "0.2.8" = import ./0.2.8 { inherit lib stdenv ruby pkgs; };
    "0.2.9" = import ./0.2.9 { inherit lib stdenv ruby pkgs; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "debase: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "debase: unknown version '${version}'")
