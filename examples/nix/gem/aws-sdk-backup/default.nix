#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-backup
#
# Versions: 1.105.0, 1.106.0, 1.107.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.107.0",
  git ? { },
}:
let
  versions = {
    "1.105.0" = import ./1.105.0 { inherit lib stdenv ruby; };
    "1.106.0" = import ./1.106.0 { inherit lib stdenv ruby; };
    "1.107.0" = import ./1.107.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-backup: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-backup: unknown version '${version}'")
