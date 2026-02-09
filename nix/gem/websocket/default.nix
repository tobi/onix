#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# websocket
#
# Available versions:
#   1.2.11
#
# Usage:
#   websocket { version = "1.2.11"; }
#   websocket { }  # latest (1.2.11)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.11",
  git ? { },
}:
let
  versions = {
    "1.2.11" = import ./1.2.11 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "websocket: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "websocket: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
