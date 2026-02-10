#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# arbre
#
# Versions: 2.1.0, 2.2.0, 2.2.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.2.1",
  git ? { },
}:
let
  versions = {
    "2.1.0" = import ./2.1.0 { inherit lib stdenv ruby; };
    "2.2.0" = import ./2.2.0 { inherit lib stdenv ruby; };
    "2.2.1" = import ./2.2.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "arbre: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "arbre: unknown version '${version}'")
