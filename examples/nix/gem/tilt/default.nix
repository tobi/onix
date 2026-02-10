#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tilt
#
# Versions: 2.3.0, 2.6.0, 2.6.1, 2.7.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.7.0",
  git ? { },
}:
let
  versions = {
    "2.3.0" = import ./2.3.0 { inherit lib stdenv ruby; };
    "2.6.0" = import ./2.6.0 { inherit lib stdenv ruby; };
    "2.6.1" = import ./2.6.1 { inherit lib stdenv ruby; };
    "2.7.0" = import ./2.7.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "tilt: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "tilt: unknown version '${version}'")
