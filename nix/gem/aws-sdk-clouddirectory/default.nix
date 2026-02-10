#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-clouddirectory
#
# Versions: 1.84.0, 1.85.0, 1.86.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.86.0",
  git ? { },
}:
let
  versions = {
    "1.84.0" = import ./1.84.0 { inherit lib stdenv ruby; };
    "1.85.0" = import ./1.85.0 { inherit lib stdenv ruby; };
    "1.86.0" = import ./1.86.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-clouddirectory: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-clouddirectory: unknown version '${version}'")
