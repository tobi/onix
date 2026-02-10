#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rbtrace
#
# Versions: 0.5.1, 0.5.2, 0.5.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.5.3",
  git ? { },
}:
let
  versions = {
    "0.5.1" = import ./0.5.1 { inherit lib stdenv ruby pkgs; };
    "0.5.2" = import ./0.5.2 { inherit lib stdenv ruby pkgs; };
    "0.5.3" = import ./0.5.3 { inherit lib stdenv ruby pkgs; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rbtrace: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rbtrace: unknown version '${version}'")
