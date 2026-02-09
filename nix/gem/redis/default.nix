#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# redis
#
# Available versions:
#   5.0.6
#   5.4.0
#
# Usage:
#   redis { version = "5.4.0"; }
#   redis { }  # latest (5.4.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.4.0",
  git ? { },
}:
let
  versions = {
    "5.0.6" = import ./5.0.6 { inherit lib stdenv ruby; };
    "5.4.0" = import ./5.4.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "redis: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "redis: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
