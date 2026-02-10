#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-pricing
#
# Versions: 1.87.0, 1.88.0, 1.89.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.89.0",
  git ? { },
}:
let
  versions = {
    "1.87.0" = import ./1.87.0 { inherit lib stdenv ruby; };
    "1.88.0" = import ./1.88.0 { inherit lib stdenv ruby; };
    "1.89.0" = import ./1.89.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-pricing: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-pricing: unknown version '${version}'")
