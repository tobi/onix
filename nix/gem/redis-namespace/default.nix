#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# redis-namespace
#
# Available versions:
#   1.10.0
#   1.11.0
#
# Usage:
#   redis-namespace { version = "1.11.0"; }
#   redis-namespace { }  # latest (1.11.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.11.0",
  git ? { },
}:
let
  versions = {
    "1.10.0" = import ./1.10.0 { inherit lib stdenv ruby; };
    "1.11.0" = import ./1.11.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "redis-namespace: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "redis-namespace: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
