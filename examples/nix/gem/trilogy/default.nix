#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# trilogy
#
# Versions: 2.9.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.9.0",
  git ? { },
}:
let
  versions = {
    "2.9.0" = import ./2.9.0 { inherit lib stdenv ruby pkgs; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "trilogy: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "trilogy: unknown version '${version}'")
