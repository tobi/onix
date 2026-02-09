#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# json
#
# Available versions:
#   2.13.2
#   2.17.1
#   2.18.0
#
# Usage:
#   json { version = "2.18.0"; }
#   json { }  # latest (2.18.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.18.0",
  git ? { },
}:
let
  versions = {
    "2.13.2" = import ./2.13.2 { inherit lib stdenv ruby; };
    "2.17.1" = import ./2.17.1 { inherit lib stdenv ruby; };
    "2.18.0" = import ./2.18.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "json: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "json: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
