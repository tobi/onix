#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-iotanalytics
#
# Versions: 1.91.0, 1.92.0, 1.93.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.93.0",
  git ? { },
}:
let
  versions = {
    "1.91.0" = import ./1.91.0 { inherit lib stdenv ruby; };
    "1.92.0" = import ./1.92.0 { inherit lib stdenv ruby; };
    "1.93.0" = import ./1.93.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-iotanalytics: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-iotanalytics: unknown version '${version}'")
