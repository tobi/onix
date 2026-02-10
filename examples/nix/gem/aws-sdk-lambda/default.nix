#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-lambda
#
# Versions: 1.173.0, 1.174.0, 1.175.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.175.0",
  git ? { },
}:
let
  versions = {
    "1.173.0" = import ./1.173.0 { inherit lib stdenv ruby; };
    "1.174.0" = import ./1.174.0 { inherit lib stdenv ruby; };
    "1.175.0" = import ./1.175.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-lambda: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-lambda: unknown version '${version}'")
