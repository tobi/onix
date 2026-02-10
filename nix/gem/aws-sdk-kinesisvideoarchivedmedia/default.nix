#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-kinesisvideoarchivedmedia
#
# Versions: 1.86.0, 1.87.0, 1.88.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.88.0",
  git ? { },
}:
let
  versions = {
    "1.86.0" = import ./1.86.0 { inherit lib stdenv ruby; };
    "1.87.0" = import ./1.87.0 { inherit lib stdenv ruby; };
    "1.88.0" = import ./1.88.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-kinesisvideoarchivedmedia: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-kinesisvideoarchivedmedia: unknown version '${version}'")
