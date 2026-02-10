#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-kms
#
# Versions: 1.99.0, 1.110.0, 1.118.0, 1.119.0, 1.120.0, 1.121.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.121.0",
  git ? { },
}:
let
  versions = {
    "1.99.0" = import ./1.99.0 { inherit lib stdenv ruby; };
    "1.110.0" = import ./1.110.0 { inherit lib stdenv ruby; };
    "1.118.0" = import ./1.118.0 { inherit lib stdenv ruby; };
    "1.119.0" = import ./1.119.0 { inherit lib stdenv ruby; };
    "1.120.0" = import ./1.120.0 { inherit lib stdenv ruby; };
    "1.121.0" = import ./1.121.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-kms: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-kms: unknown version '${version}'")
