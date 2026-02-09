#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pg
#
# Available versions:
#   1.5.3
#   1.6.2
#
# Usage:
#   pg { version = "1.6.2"; }
#   pg { }  # latest (1.6.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.6.2",
  git ? { },
}:
let
  versions = {
    "1.5.3" = import ./1.5.3 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
    "1.6.2" = import ./1.6.2 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "pg: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "pg: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
