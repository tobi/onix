#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# actionview_precompiler
#
# Versions: 0.4.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.4.0",
  git ? { },
}:
let
  versions = {
    "0.4.0" = import ./0.4.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "actionview_precompiler: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "actionview_precompiler: unknown version '${version}'")
