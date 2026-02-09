#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# nokogiri
#
# Available versions:
#   1.18.9
#   1.18.10
#   1.19.0
#
# Usage:
#   nokogiri { version = "1.19.0"; }
#   nokogiri { }  # latest (1.19.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.19.0",
  git ? { },
}:
let
  versions = {
    "1.18.9" = import ./1.18.9 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
    "1.18.10" = import ./1.18.10 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
    "1.19.0" = import ./1.19.0 {
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
    or (throw "nokogiri: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "nokogiri: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
