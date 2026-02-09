#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# liquid
#
# Available versions:
#   5.4.0
#
# Usage:
#   liquid { version = "5.4.0"; }
#   liquid { }  # latest (5.4.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.4.0",
  git ? { },
}:
let
  versions = {
    "5.4.0" = import ./5.4.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "liquid: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "liquid: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
