#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-mediaconvert
#
# Versions: 1.165.0, 1.177.0, 1.178.0, 1.179.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.179.0",
  git ? { },
}:
let
  versions = {
    "1.165.0" = import ./1.165.0 { inherit lib stdenv ruby; };
    "1.177.0" = import ./1.177.0 { inherit lib stdenv ruby; };
    "1.178.0" = import ./1.178.0 { inherit lib stdenv ruby; };
    "1.179.0" = import ./1.179.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-mediaconvert: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-mediaconvert: unknown version '${version}'")
