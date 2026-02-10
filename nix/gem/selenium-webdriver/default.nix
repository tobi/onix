#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# selenium-webdriver
#
# Versions: 4.32.0, 4.38.0, 4.39.0, 4.40.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.40.0",
  git ? { },
}:
let
  versions = {
    "4.32.0" = import ./4.32.0 { inherit lib stdenv ruby; };
    "4.38.0" = import ./4.38.0 { inherit lib stdenv ruby; };
    "4.39.0" = import ./4.39.0 { inherit lib stdenv ruby; };
    "4.40.0" = import ./4.40.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "selenium-webdriver: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "selenium-webdriver: unknown version '${version}'")
