#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mock_redis
#
# Available versions:
#   0.36.0
#
# Usage:
#   mock_redis { version = "0.36.0"; }
#   mock_redis { }  # latest (0.36.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.36.0",
  git ? { },
}:
let
  versions = {
    "0.36.0" = import ./0.36.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mock_redis: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "mock_redis: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
