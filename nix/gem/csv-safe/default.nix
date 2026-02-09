#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# csv-safe
#
# Available versions:
#   3.3.1
#
# Usage:
#   csv-safe { version = "3.3.1"; }
#   csv-safe { }  # latest (3.3.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.3.1",
  git ? { },
}:
let
  versions = {
    "3.3.1" = import ./3.3.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "csv-safe: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "csv-safe: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
