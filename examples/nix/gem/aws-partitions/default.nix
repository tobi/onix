#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-partitions
#
# Versions: 1.1134.0, 1.1150.0, 1.1198.0, 1.1203.0, 1.1211.0, 1.1212.0, 1.1213.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.1213.0",
  git ? { },
}:
let
  versions = {
    "1.1134.0" = import ./1.1134.0 { inherit lib stdenv ruby; };
    "1.1150.0" = import ./1.1150.0 { inherit lib stdenv ruby; };
    "1.1198.0" = import ./1.1198.0 { inherit lib stdenv ruby; };
    "1.1203.0" = import ./1.1203.0 { inherit lib stdenv ruby; };
    "1.1211.0" = import ./1.1211.0 { inherit lib stdenv ruby; };
    "1.1212.0" = import ./1.1212.0 { inherit lib stdenv ruby; };
    "1.1213.0" = import ./1.1213.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-partitions: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-partitions: unknown version '${version}'")
