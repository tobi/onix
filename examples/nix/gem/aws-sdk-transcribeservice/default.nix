#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-transcribeservice
#
# Versions: 1.134.0, 1.135.0, 1.136.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.136.0",
  git ? { },
}:
let
  versions = {
    "1.134.0" = import ./1.134.0 { inherit lib stdenv ruby; };
    "1.135.0" = import ./1.135.0 { inherit lib stdenv ruby; };
    "1.136.0" = import ./1.136.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-transcribeservice: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-transcribeservice: unknown version '${version}'")
