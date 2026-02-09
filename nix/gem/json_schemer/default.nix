#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# json_schemer
#
# Available versions:
#   0.2.24
#   2.5.0
#
# Usage:
#   json_schemer { version = "2.5.0"; }
#   json_schemer { }  # latest (2.5.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.5.0",
  git ? { },
}:
let
  versions = {
    "0.2.24" = import ./0.2.24 { inherit lib stdenv ruby; };
    "2.5.0" = import ./2.5.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "json_schemer: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "json_schemer: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
