#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# nokogiri
#
# Versions: 1.16.5, 1.18.9, 1.18.10, 1.19.0
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
    "1.16.5" = import ./1.16.5 { inherit lib stdenv ruby pkgs; };
    "1.18.9" = import ./1.18.9 { inherit lib stdenv ruby pkgs; };
    "1.18.10" = import ./1.18.10 { inherit lib stdenv ruby pkgs; };
    "1.19.0" = import ./1.19.0 { inherit lib stdenv ruby pkgs; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "nokogiri: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "nokogiri: unknown version '${version}'")
