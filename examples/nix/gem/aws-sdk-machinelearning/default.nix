#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-machinelearning
#
# Versions: 1.81.0, 1.82.0, 1.83.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.83.0",
  git ? { },
}:
let
  versions = {
    "1.81.0" = import ./1.81.0 { inherit lib stdenv ruby; };
    "1.82.0" = import ./1.82.0 { inherit lib stdenv ruby; };
    "1.83.0" = import ./1.83.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-machinelearning: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-machinelearning: unknown version '${version}'")
