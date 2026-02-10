#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-alexaforbusiness
#
# Versions: 1.69.0, 1.70.0, 1.71.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.71.0",
  git ? { },
}:
let
  versions = {
    "1.69.0" = import ./1.69.0 { inherit lib stdenv ruby; };
    "1.70.0" = import ./1.70.0 { inherit lib stdenv ruby; };
    "1.71.0" = import ./1.71.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-alexaforbusiness: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-alexaforbusiness: unknown version '${version}'")
