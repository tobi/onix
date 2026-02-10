#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-s3control
#
# Versions: 1.124.0, 1.125.0, 1.126.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.126.0",
  git ? { },
}:
let
  versions = {
    "1.124.0" = import ./1.124.0 { inherit lib stdenv ruby; };
    "1.125.0" = import ./1.125.0 { inherit lib stdenv ruby; };
    "1.126.0" = import ./1.126.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-s3control: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-s3control: unknown version '${version}'")
