#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pdf-reader
#
# Available versions:
#   2.15.0
#
# Usage:
#   pdf-reader { version = "2.15.0"; }
#   pdf-reader { }  # latest (2.15.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.15.0",
  git ? { },
}:
let
  versions = {
    "2.15.0" = import ./2.15.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "pdf-reader: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "pdf-reader: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
