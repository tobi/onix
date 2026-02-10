#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-ebs
#
# Versions: 1.68.0, 1.69.0, 1.70.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.70.0",
  git ? { },
}:
let
  versions = {
    "1.68.0" = import ./1.68.0 { inherit lib stdenv ruby; };
    "1.69.0" = import ./1.69.0 { inherit lib stdenv ruby; };
    "1.70.0" = import ./1.70.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-ebs: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-ebs: unknown version '${version}'")
