#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-iotsecuretunneling
#
# Versions: 1.62.0, 1.63.0, 1.64.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.64.0",
  git ? { },
}:
let
  versions = {
    "1.62.0" = import ./1.62.0 { inherit lib stdenv ruby; };
    "1.63.0" = import ./1.63.0 { inherit lib stdenv ruby; };
    "1.64.0" = import ./1.64.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-iotsecuretunneling: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-iotsecuretunneling: unknown version '${version}'")
