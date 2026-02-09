#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tty-prompt
#
# Available versions:
#   0.23.1
#
# Usage:
#   tty-prompt { version = "0.23.1"; }
#   tty-prompt { }  # latest (0.23.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.23.1",
  git ? { },
}:
let
  versions = {
    "0.23.1" = import ./0.23.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "tty-prompt: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "tty-prompt: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
