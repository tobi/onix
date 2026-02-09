#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# stackprof
#
# Available versions:
#   0.2.25
#   0.2.27
#
# Usage:
#   stackprof { version = "0.2.27"; }
#   stackprof { }  # latest (0.2.27)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.2.27",
  git ? { },
}:
let
  versions = {
    "0.2.25" = import ./0.2.25 { inherit lib stdenv ruby; };
    "0.2.27" = import ./0.2.27 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "stackprof: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "stackprof: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
