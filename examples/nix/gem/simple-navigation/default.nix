#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# simple-navigation
#
# Versions: 4.4.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.4.1",
  git ? { },
}:
let
  versions = {
    "4.4.1" = import ./4.4.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "simple-navigation: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "simple-navigation: unknown version '${version}'")
