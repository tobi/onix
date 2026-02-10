#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-iot1clickprojects
#
# Versions: 1.63.0, 1.64.0, 1.65.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.65.0",
  git ? { },
}:
let
  versions = {
    "1.63.0" = import ./1.63.0 { inherit lib stdenv ruby; };
    "1.64.0" = import ./1.64.0 { inherit lib stdenv ruby; };
    "1.65.0" = import ./1.65.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-iot1clickprojects: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-iot1clickprojects: unknown version '${version}'")
