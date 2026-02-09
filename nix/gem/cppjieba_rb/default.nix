#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cppjieba_rb
#
# Available versions:
#   0.4.4
#
# Usage:
#   cppjieba_rb { version = "0.4.4"; }
#   cppjieba_rb { }  # latest (0.4.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.4.4",
  git ? { },
}:
let
  versions = {
    "0.4.4" = import ./0.4.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "cppjieba_rb: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "cppjieba_rb: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
