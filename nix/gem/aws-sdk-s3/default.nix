#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-s3
#
# Available versions:
#   1.182.0
#   1.208.0
#   1.211.0
#
# Usage:
#   aws-sdk-s3 { version = "1.211.0"; }
#   aws-sdk-s3 { }  # latest (1.211.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.211.0",
  git ? { },
}:
let
  versions = {
    "1.182.0" = import ./1.182.0 { inherit lib stdenv ruby; };
    "1.208.0" = import ./1.208.0 { inherit lib stdenv ruby; };
    "1.211.0" = import ./1.211.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-s3: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-s3: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
