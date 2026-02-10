#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pry
#
# Versions: 0.14.2, 0.15.1, 0.15.2, 0.16.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.16.0",
  git ? { },
}:
let
  versions = {
    "0.14.2" = import ./0.14.2 { inherit lib stdenv ruby; };
    "0.15.1" = import ./0.15.1 { inherit lib stdenv ruby; };
    "0.15.2" = import ./0.15.2 { inherit lib stdenv ruby; };
    "0.16.0" = import ./0.16.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "pry: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "pry: unknown version '${version}'")
