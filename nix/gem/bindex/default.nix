#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# bindex
#
# Available versions:
#   0.8.1
#
# Usage:
#   bindex { version = "0.8.1"; }
#   bindex { }  # latest (0.8.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.8.1",
  git ? { },
}:
let
  versions = {
    "0.8.1" = import ./0.8.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "bindex: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "bindex: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
