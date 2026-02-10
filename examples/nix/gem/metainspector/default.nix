#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# metainspector
#
# Versions: 5.15.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.15.0",
  git ? { },
}:
let
  versions = {
    "5.15.0" = import ./5.15.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "metainspector: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "metainspector: unknown version '${version}'")
