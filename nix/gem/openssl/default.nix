#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# openssl
#
# Available versions:
#   3.2.0
#   3.3.2
#   4.0.0
#
# Usage:
#   openssl { version = "4.0.0"; }
#   openssl { }  # latest (4.0.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.0.0",
  git ? { },
}:
let
  versions = {
    "3.2.0" = import ./3.2.0 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
    "3.3.2" = import ./3.3.2 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
    "4.0.0" = import ./4.0.0 {
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
    or (throw "openssl: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "openssl: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
