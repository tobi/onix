#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mini_racer
#
# Versions: 0.19.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.19.1",
  git ? { },
}:
let
  versions = {
    "0.19.1" = import ./0.19.1 { inherit lib stdenv ruby pkgs; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mini_racer: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "mini_racer: unknown version '${version}'")
