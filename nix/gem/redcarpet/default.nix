#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# redcarpet
#
# Available versions:
#   3.6.1
#
# Usage:
#   redcarpet { version = "3.6.1"; }
#   redcarpet { }  # latest (3.6.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.6.1",
  git ? { },
}:
let
  versions = {
    "3.6.1" = import ./3.6.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "redcarpet: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "redcarpet: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
