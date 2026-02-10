#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# therubyracer
#
# Versions: 0.12.1, 0.12.2, 0.12.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.12.3",
  git ? { },
}:
let
  versions = {
    "0.12.1" = import ./0.12.1 { inherit lib stdenv ruby pkgs; };
    "0.12.2" = import ./0.12.2 { inherit lib stdenv ruby pkgs; };
    "0.12.3" = import ./0.12.3 { inherit lib stdenv ruby pkgs; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "therubyracer: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "therubyracer: unknown version '${version}'")
