#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# jbuilder
#
# Available versions:
#   2.11.5
#   2.14.1
#
# Usage:
#   jbuilder { version = "2.14.1"; }
#   jbuilder { }  # latest (2.14.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.14.1",
  git ? { },
}:
let
  versions = {
    "2.11.5" = import ./2.11.5 { inherit lib stdenv ruby; };
    "2.14.1" = import ./2.14.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "jbuilder: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "jbuilder: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
