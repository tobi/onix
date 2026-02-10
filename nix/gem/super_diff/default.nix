#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# super_diff
#
# Versions: 0.18.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.18.0",
  git ? { },
}:
let
  versions = {
    "0.18.0" = import ./0.18.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "super_diff: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "super_diff: unknown version '${version}'")
