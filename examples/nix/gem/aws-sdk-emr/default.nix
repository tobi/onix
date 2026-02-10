#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-emr
#
# Versions: 1.123.0, 1.124.0, 1.125.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.125.0",
  git ? { },
}:
let
  versions = {
    "1.123.0" = import ./1.123.0 { inherit lib stdenv ruby; };
    "1.124.0" = import ./1.124.0 { inherit lib stdenv ruby; };
    "1.125.0" = import ./1.125.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-emr: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-emr: unknown version '${version}'")
