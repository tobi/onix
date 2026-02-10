#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-ssm
#
# Versions: 1.208.0, 1.209.0, 1.210.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.210.0",
  git ? { },
}:
let
  versions = {
    "1.208.0" = import ./1.208.0 { inherit lib stdenv ruby; };
    "1.209.0" = import ./1.209.0 { inherit lib stdenv ruby; };
    "1.210.0" = import ./1.210.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-ssm: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-ssm: unknown version '${version}'")
