#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-kms
#
# Available versions:
#   1.99.0
#   1.118.0
#   1.120.0
#
# Usage:
#   aws-sdk-kms { version = "1.120.0"; }
#   aws-sdk-kms { }  # latest (1.120.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.120.0",
  git ? { },
}:
let
  versions = {
    "1.99.0" = import ./1.99.0 { inherit lib stdenv ruby; };
    "1.118.0" = import ./1.118.0 { inherit lib stdenv ruby; };
    "1.120.0" = import ./1.120.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-kms: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-kms: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
