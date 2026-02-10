#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-sagemaker
#
# Versions: 1.348.0, 1.349.0, 1.350.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.350.0",
  git ? { },
}:
let
  versions = {
    "1.348.0" = import ./1.348.0 { inherit lib stdenv ruby; };
    "1.349.0" = import ./1.349.0 { inherit lib stdenv ruby; };
    "1.350.0" = import ./1.350.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-sagemaker: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-sagemaker: unknown version '${version}'")
