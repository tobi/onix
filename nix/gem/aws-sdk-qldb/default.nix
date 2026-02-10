#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-qldb
#
# Versions: 1.65.0, 1.66.0, 1.67.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.67.0",
  git ? { },
}:
let
  versions = {
    "1.65.0" = import ./1.65.0 { inherit lib stdenv ruby; };
    "1.66.0" = import ./1.66.0 { inherit lib stdenv ruby; };
    "1.67.0" = import ./1.67.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-qldb: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-qldb: unknown version '${version}'")
