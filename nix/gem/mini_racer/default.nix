#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mini_racer
#
# Available versions:
#   0.19.1
#
# Usage:
#   mini_racer { version = "0.19.1"; }
#   mini_racer { }  # latest (0.19.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.19.1",
  git ? { },
}:
let
  versions = {
    "0.19.1" = import ./0.19.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mini_racer: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "mini_racer: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
