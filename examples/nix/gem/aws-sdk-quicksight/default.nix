#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-quicksight
#
# Versions: 1.170.0, 1.171.0, 1.172.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.172.0",
  git ? { },
}:
let
  versions = {
    "1.170.0" = import ./1.170.0 { inherit lib stdenv ruby; };
    "1.171.0" = import ./1.171.0 { inherit lib stdenv ruby; };
    "1.172.0" = import ./1.172.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-quicksight: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-quicksight: unknown version '${version}'")
