#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# libdatadog
#
# Available versions:
#   18.1.0.1.0
#
# Usage:
#   libdatadog { version = "18.1.0.1.0"; }
#   libdatadog { }  # latest (18.1.0.1.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "18.1.0.1.0",
  git ? { },
}:
let
  versions = {
    "18.1.0.1.0" = import ./18.1.0.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "libdatadog: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "libdatadog: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
