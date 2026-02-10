#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sequel
#
# Versions: 5.99.0, 5.100.0, 5.101.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.101.0",
  git ? { },
}:
let
  versions = {
    "5.99.0" = import ./5.99.0 { inherit lib stdenv ruby; };
    "5.100.0" = import ./5.100.0 { inherit lib stdenv ruby; };
    "5.101.0" = import ./5.101.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sequel: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "sequel: unknown version '${version}'")
