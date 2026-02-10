#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# useragent
#
# Versions: 0.16.9, 0.16.10, 0.16.11
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.16.11",
  git ? { },
}:
let
  versions = {
    "0.16.9" = import ./0.16.9 { inherit lib stdenv ruby; };
    "0.16.10" = import ./0.16.10 { inherit lib stdenv ruby; };
    "0.16.11" = import ./0.16.11 { inherit lib stdenv ruby; };
  };

  gitRevs = {
    "433ca320a42d" = import ./git-433ca320a42d { inherit lib stdenv ruby; };
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "useragent: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "useragent: unknown version '${version}'")
