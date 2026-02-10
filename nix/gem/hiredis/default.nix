#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# hiredis
#
# Versions: 0.6.1, 0.6.2, 0.6.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.6.3",
  git ? { },
}:
let
  versions = {
    "0.6.1" = import ./0.6.1 { inherit lib stdenv ruby pkgs; };
    "0.6.2" = import ./0.6.2 { inherit lib stdenv ruby pkgs; };
    "0.6.3" = import ./0.6.3 { inherit lib stdenv ruby pkgs; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "hiredis: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "hiredis: unknown version '${version}'")
