#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rack-contrib
#
# Versions: 2.5.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.5.0",
  git ? { },
}:
let
  versions = {
    "2.5.0" = import ./2.5.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rack-contrib: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rack-contrib: unknown version '${version}'")
