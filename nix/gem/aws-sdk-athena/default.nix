#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-athena
#
# Versions: 1.115.0, 1.116.0, 1.117.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.117.0",
  git ? { },
}:
let
  versions = {
    "1.115.0" = import ./1.115.0 { inherit lib stdenv ruby; };
    "1.116.0" = import ./1.116.0 { inherit lib stdenv ruby; };
    "1.117.0" = import ./1.117.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-athena: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-athena: unknown version '${version}'")
