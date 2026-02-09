#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tty-cursor
#
# Available versions:
#   0.7.1
#
# Usage:
#   tty-cursor { version = "0.7.1"; }
#   tty-cursor { }  # latest (0.7.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.7.1",
  git ? { },
}:
let
  versions = {
    "0.7.1" = import ./0.7.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "tty-cursor: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "tty-cursor: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
