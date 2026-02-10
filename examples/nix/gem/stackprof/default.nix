#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# stackprof
#
# Versions: 0.2.25, 0.2.26, 0.2.27
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.2.27",
  git ? { },
}:
let
  versions = {
    "0.2.25" = import ./0.2.25 { inherit lib stdenv ruby; };
    "0.2.26" = import ./0.2.26 { inherit lib stdenv ruby; };
    "0.2.27" = import ./0.2.27 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "stackprof: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "stackprof: unknown version '${version}'")
