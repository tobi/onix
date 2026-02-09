#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-mediaconvert
#
# Available versions:
#   1.165.0
#
# Usage:
#   aws-sdk-mediaconvert { version = "1.165.0"; }
#   aws-sdk-mediaconvert { }  # latest (1.165.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.165.0",
  git ? { },
}:
let
  versions = {
    "1.165.0" = import ./1.165.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-mediaconvert: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-mediaconvert: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
