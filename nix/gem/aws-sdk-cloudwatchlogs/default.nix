#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-cloudwatchlogs
#
# Versions: 1.136.0, 1.137.0, 1.138.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.138.0",
  git ? { },
}:
let
  versions = {
    "1.136.0" = import ./1.136.0 { inherit lib stdenv ruby; };
    "1.137.0" = import ./1.137.0 { inherit lib stdenv ruby; };
    "1.138.0" = import ./1.138.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-cloudwatchlogs: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-cloudwatchlogs: unknown version '${version}'")
