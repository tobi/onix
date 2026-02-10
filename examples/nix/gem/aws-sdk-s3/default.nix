#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-s3
#
# Versions: 1.182.0, 1.197.0, 1.208.0, 1.211.0, 1.212.0, 1.213.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.213.0",
  git ? { },
}:
let
  versions = {
    "1.182.0" = import ./1.182.0 { inherit lib stdenv ruby; };
    "1.197.0" = import ./1.197.0 { inherit lib stdenv ruby; };
    "1.208.0" = import ./1.208.0 { inherit lib stdenv ruby; };
    "1.211.0" = import ./1.211.0 { inherit lib stdenv ruby; };
    "1.212.0" = import ./1.212.0 { inherit lib stdenv ruby; };
    "1.213.0" = import ./1.213.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-s3: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-s3: unknown version '${version}'")
