#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# spring
#
# Available versions:
#   4.1.1
#
# Usage:
#   spring { version = "4.1.1"; }
#   spring { }  # latest (4.1.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.1.1",
  git ? { },
}:
let
  versions = {
    "4.1.1" = import ./4.1.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "spring: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "spring: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
