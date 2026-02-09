#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rouge
#
# Available versions:
#   4.7.0
#
# Usage:
#   rouge { version = "4.7.0"; }
#   rouge { }  # latest (4.7.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.7.0",
  git ? { },
}:
let
  versions = {
    "4.7.0" = import ./4.7.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rouge: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rouge: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
