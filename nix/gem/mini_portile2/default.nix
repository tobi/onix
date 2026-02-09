#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mini_portile2
#
# Available versions:
#   2.8.9
#
# Usage:
#   mini_portile2 { version = "2.8.9"; }
#   mini_portile2 { }  # latest (2.8.9)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.8.9",
  git ? { },
}:
let
  versions = {
    "2.8.9" = import ./2.8.9 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mini_portile2: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "mini_portile2: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
