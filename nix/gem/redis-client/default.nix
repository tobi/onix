#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# redis-client
#
# Available versions:
#   0.22.2
#   0.26.1
#
# Usage:
#   redis-client { version = "0.26.1"; }
#   redis-client { }  # latest (0.26.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.26.1",
  git ? { },
}:
let
  versions = {
    "0.22.2" = import ./0.22.2 { inherit lib stdenv ruby; };
    "0.26.1" = import ./0.26.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "redis-client: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "redis-client: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
