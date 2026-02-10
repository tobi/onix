#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-sagemakerruntime
#
# Versions: 1.92.0, 1.93.0, 1.94.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.94.0",
  git ? { },
}:
let
  versions = {
    "1.92.0" = import ./1.92.0 { inherit lib stdenv ruby; };
    "1.93.0" = import ./1.93.0 { inherit lib stdenv ruby; };
    "1.94.0" = import ./1.94.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-sagemakerruntime: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-sagemakerruntime: unknown version '${version}'")
