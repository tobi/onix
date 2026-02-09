#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# selenium-webdriver
#
# Available versions:
#   4.39.0
#
# Usage:
#   selenium-webdriver { version = "4.39.0"; }
#   selenium-webdriver { }  # latest (4.39.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.39.0",
  git ? { },
}:
let
  versions = {
    "4.39.0" = import ./4.39.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "selenium-webdriver: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "selenium-webdriver: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
