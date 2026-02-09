#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rack-contrib
#
# Available versions:
#   2.5.0
#
# Usage:
#   rack-contrib { version = "2.5.0"; }
#   rack-contrib { }  # latest (2.5.0)
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
    "2.5.0" = import ./2.5.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rack-contrib: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rack-contrib: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
