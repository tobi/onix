#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# maxminddb
#
# Available versions:
#   0.1.22
#
# Usage:
#   maxminddb { version = "0.1.22"; }
#   maxminddb { }  # latest (0.1.22)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.1.22",
  git ? { },
}:
let
  versions = {
    "0.1.22" = import ./0.1.22 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "maxminddb: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "maxminddb: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
