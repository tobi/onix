#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-computeoptimizer
#
# Versions: 1.88.0, 1.89.0, 1.90.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.90.0",
  git ? { },
}:
let
  versions = {
    "1.88.0" = import ./1.88.0 { inherit lib stdenv ruby; };
    "1.89.0" = import ./1.89.0 { inherit lib stdenv ruby; };
    "1.90.0" = import ./1.90.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-computeoptimizer: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-computeoptimizer: unknown version '${version}'")
