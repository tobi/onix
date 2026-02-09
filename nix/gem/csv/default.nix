#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# csv
#
# Available versions:
#   3.3.0
#   3.3.5
#
# Usage:
#   csv { version = "3.3.5"; }
#   csv { }  # latest (3.3.5)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.3.5",
  git ? { },
}:
let
  versions = {
    "3.3.0" = import ./3.3.0 { inherit lib stdenv ruby; };
    "3.3.5" = import ./3.3.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "csv: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "csv: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
