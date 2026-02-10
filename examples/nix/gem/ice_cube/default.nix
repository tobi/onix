#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ice_cube
#
# Versions: 0.16.3, 0.16.4, 0.17.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.17.0",
  git ? { },
}:
let
  versions = {
    "0.16.3" = import ./0.16.3 { inherit lib stdenv ruby; };
    "0.16.4" = import ./0.16.4 { inherit lib stdenv ruby; };
    "0.17.0" = import ./0.17.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ice_cube: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "ice_cube: unknown version '${version}'")
