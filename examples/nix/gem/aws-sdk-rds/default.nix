#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-rds
#
# Versions: 1.304.0, 1.305.0, 1.306.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.306.0",
  git ? { },
}:
let
  versions = {
    "1.304.0" = import ./1.304.0 { inherit lib stdenv ruby; };
    "1.305.0" = import ./1.305.0 { inherit lib stdenv ruby; };
    "1.306.0" = import ./1.306.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-rds: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-rds: unknown version '${version}'")
