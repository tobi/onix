#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# hashery
#
# Versions: 2.1.1, 2.1.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.1.2",
  git ? { },
}:
let
  versions = {
    "2.1.1" = import ./2.1.1 { inherit lib stdenv ruby; };
    "2.1.2" = import ./2.1.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "hashery: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "hashery: unknown version '${version}'")
