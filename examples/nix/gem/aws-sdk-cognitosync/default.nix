#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-cognitosync
#
# Versions: 1.77.0, 1.78.0, 1.79.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.79.0",
  git ? { },
}:
let
  versions = {
    "1.77.0" = import ./1.77.0 { inherit lib stdenv ruby; };
    "1.78.0" = import ./1.78.0 { inherit lib stdenv ruby; };
    "1.79.0" = import ./1.79.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-cognitosync: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-cognitosync: unknown version '${version}'")
