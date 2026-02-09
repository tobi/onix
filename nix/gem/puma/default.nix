#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# puma
#
# Available versions:
#   6.4.3
#   7.1.0
#
# Usage:
#   puma { version = "7.1.0"; }
#   puma { }  # latest (7.1.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "7.1.0",
  git ? { },
}:
let
  versions = {
    "6.4.3" = import ./6.4.3 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
    "7.1.0" = import ./7.1.0 {
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
    or (throw "puma: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "puma: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
