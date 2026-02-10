#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-eks
#
# Versions: 1.155.0, 1.156.0, 1.157.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.157.0",
  git ? { },
}:
let
  versions = {
    "1.155.0" = import ./1.155.0 { inherit lib stdenv ruby; };
    "1.156.0" = import ./1.156.0 { inherit lib stdenv ruby; };
    "1.157.0" = import ./1.157.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-eks: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-eks: unknown version '${version}'")
