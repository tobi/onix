#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# color_diff
#
# Versions: 0.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.2",
  git ? { },
}:
let
  versions = {
    "0.2" = import ./0.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "color_diff: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "color_diff: unknown version '${version}'")
