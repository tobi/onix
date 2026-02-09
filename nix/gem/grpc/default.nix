#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# grpc
#
# Available versions:
#   1.72.0
#
# Usage:
#   grpc { version = "1.72.0"; }
#   grpc { }  # latest (1.72.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.72.0",
  git ? { },
}:
let
  versions = {
    "1.72.0" = import ./1.72.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "grpc: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "grpc: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
