#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-databasemigrationservice
#
# Versions: 1.137.0, 1.138.0, 1.139.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.139.0",
  git ? { },
}:
let
  versions = {
    "1.137.0" = import ./1.137.0 { inherit lib stdenv ruby; };
    "1.138.0" = import ./1.138.0 { inherit lib stdenv ruby; };
    "1.139.0" = import ./1.139.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-databasemigrationservice: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-databasemigrationservice: unknown version '${version}'")
