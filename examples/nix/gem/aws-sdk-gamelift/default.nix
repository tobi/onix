#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-gamelift
#
# Versions: 1.117.0, 1.118.0, 1.119.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.119.0",
  git ? { },
}:
let
  versions = {
    "1.117.0" = import ./1.117.0 { inherit lib stdenv ruby; };
    "1.118.0" = import ./1.118.0 { inherit lib stdenv ruby; };
    "1.119.0" = import ./1.119.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-gamelift: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-gamelift: unknown version '${version}'")
