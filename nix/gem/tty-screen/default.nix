#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tty-screen
#
# Available versions:
#   0.8.2
#
# Usage:
#   tty-screen { version = "0.8.2"; }
#   tty-screen { }  # latest (0.8.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.8.2",
  git ? { },
}:
let
  versions = {
    "0.8.2" = import ./0.8.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "tty-screen: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "tty-screen: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
