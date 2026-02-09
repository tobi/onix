#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# kaminari-activerecord
#
# Available versions:
#   1.2.2
#
# Usage:
#   kaminari-activerecord { version = "1.2.2"; }
#   kaminari-activerecord { }  # latest (1.2.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.2",
  git ? { },
}:
let
  versions = {
    "1.2.2" = import ./1.2.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "kaminari-activerecord: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "kaminari-activerecord: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
