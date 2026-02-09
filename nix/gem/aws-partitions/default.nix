#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-partitions
#
# Available versions:
#   1.1134.0
#   1.1198.0
#   1.1203.0
#
# Usage:
#   aws-partitions { version = "1.1203.0"; }
#   aws-partitions { }  # latest (1.1203.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.1203.0",
  git ? { },
}:
let
  versions = {
    "1.1134.0" = import ./1.1134.0 { inherit lib stdenv ruby; };
    "1.1198.0" = import ./1.1198.0 { inherit lib stdenv ruby; };
    "1.1203.0" = import ./1.1203.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-partitions: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-partitions: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
