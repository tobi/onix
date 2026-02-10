#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-codeguruprofiler
#
# Versions: 1.64.0, 1.65.0, 1.66.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.66.0",
  git ? { },
}:
let
  versions = {
    "1.64.0" = import ./1.64.0 { inherit lib stdenv ruby; };
    "1.65.0" = import ./1.65.0 { inherit lib stdenv ruby; };
    "1.66.0" = import ./1.66.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-codeguruprofiler: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-codeguruprofiler: unknown version '${version}'")
