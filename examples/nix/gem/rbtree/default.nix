#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rbtree
#
# Versions: 0.4.4, 0.4.5, 0.4.6
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.4.6",
  git ? { },
}:
let
  versions = {
    "0.4.4" = import ./0.4.4 { inherit lib stdenv ruby; };
    "0.4.5" = import ./0.4.5 { inherit lib stdenv ruby; };
    "0.4.6" = import ./0.4.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rbtree: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rbtree: unknown version '${version}'")
