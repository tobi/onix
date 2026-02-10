#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-iot
#
# Versions: 1.161.0, 1.162.0, 1.163.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.163.0",
  git ? { },
}:
let
  versions = {
    "1.161.0" = import ./1.161.0 { inherit lib stdenv ruby; };
    "1.162.0" = import ./1.162.0 { inherit lib stdenv ruby; };
    "1.163.0" = import ./1.163.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-iot: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-iot: unknown version '${version}'")
