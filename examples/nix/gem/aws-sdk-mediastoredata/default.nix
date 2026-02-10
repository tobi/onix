#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-mediastoredata
#
# Versions: 1.79.0, 1.80.0, 1.81.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.81.0",
  git ? { },
}:
let
  versions = {
    "1.79.0" = import ./1.79.0 { inherit lib stdenv ruby; };
    "1.80.0" = import ./1.80.0 { inherit lib stdenv ruby; };
    "1.81.0" = import ./1.81.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-mediastoredata: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-mediastoredata: unknown version '${version}'")
