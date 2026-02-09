#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-sns
#
# Available versions:
#   1.70.0
#   1.96.0
#
# Usage:
#   aws-sdk-sns { version = "1.96.0"; }
#   aws-sdk-sns { }  # latest (1.96.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.96.0",
  git ? { },
}:
let
  versions = {
    "1.70.0" = import ./1.70.0 { inherit lib stdenv ruby; };
    "1.96.0" = import ./1.96.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-sns: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sdk-sns: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
