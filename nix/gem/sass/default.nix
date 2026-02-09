#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sass
#
# Available versions:
#   3.7.4
#
# Usage:
#   sass { version = "3.7.4"; }
#   sass { }  # latest (3.7.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.7.4",
  git ? { },
}:
let
  versions = {
    "3.7.4" = import ./3.7.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sass: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "sass: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
