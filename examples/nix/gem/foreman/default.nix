#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# foreman
#
# Versions: 0.87.2, 0.88.1, 0.89.1, 0.90.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.90.0",
  git ? { },
}:
let
  versions = {
    "0.87.2" = import ./0.87.2 { inherit lib stdenv ruby; };
    "0.88.1" = import ./0.88.1 { inherit lib stdenv ruby; };
    "0.89.1" = import ./0.89.1 { inherit lib stdenv ruby; };
    "0.90.0" = import ./0.90.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "foreman: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "foreman: unknown version '${version}'")
