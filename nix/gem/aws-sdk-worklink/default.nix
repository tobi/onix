#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-worklink
#
# Versions: 1.53.0, 1.54.0, 1.55.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.55.0",
  git ? { },
}:
let
  versions = {
    "1.53.0" = import ./1.53.0 { inherit lib stdenv ruby; };
    "1.54.0" = import ./1.54.0 { inherit lib stdenv ruby; };
    "1.55.0" = import ./1.55.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-worklink: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-worklink: unknown version '${version}'")
