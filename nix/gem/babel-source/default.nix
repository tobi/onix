#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# babel-source
#
# Versions: 5.8.33, 5.8.34, 5.8.35
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.8.35",
  git ? { },
}:
let
  versions = {
    "5.8.33" = import ./5.8.33 { inherit lib stdenv ruby; };
    "5.8.34" = import ./5.8.34 { inherit lib stdenv ruby; };
    "5.8.35" = import ./5.8.35 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "babel-source: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "babel-source: unknown version '${version}'")
