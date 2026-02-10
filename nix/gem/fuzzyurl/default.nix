#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fuzzyurl
#
# Versions: 0.2.3, 0.8.0, 0.9.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.9.0",
  git ? { },
}:
let
  versions = {
    "0.2.3" = import ./0.2.3 { inherit lib stdenv ruby; };
    "0.8.0" = import ./0.8.0 { inherit lib stdenv ruby; };
    "0.9.0" = import ./0.9.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "fuzzyurl: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "fuzzyurl: unknown version '${version}'")
