#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sqlite3
#
# Available versions:
#   2.8.0
#   2.8.1
#
# Usage:
#   sqlite3 { version = "2.8.1"; }
#   sqlite3 { }  # latest (2.8.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.8.1",
  git ? { },
}:
let
  versions = {
    "2.8.0" = import ./2.8.0 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
    "2.8.1" = import ./2.8.1 {
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
    or (throw "sqlite3: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "sqlite3: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
