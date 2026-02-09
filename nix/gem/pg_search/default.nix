#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pg_search
#
# Available versions:
#   2.3.6
#
# Usage:
#   pg_search { version = "2.3.6"; }
#   pg_search { }  # latest (2.3.6)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.3.6",
  git ? { },
}:
let
  versions = {
    "2.3.6" = import ./2.3.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "pg_search: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "pg_search: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
