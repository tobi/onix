#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# database_cleaner
#
# Available versions:
#   2.0.2
#
# Usage:
#   database_cleaner { version = "2.0.2"; }
#   database_cleaner { }  # latest (2.0.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.0.2",
  git ? { },
}:
let
  versions = {
    "2.0.2" = import ./2.0.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "database_cleaner: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "database_cleaner: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
