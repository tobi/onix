#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pg
#
# Versions: 1.5.3, 1.5.6, 1.6.1, 1.6.2, 1.6.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.6.3",
  git ? { },
}:
let
  versions = {
    "1.5.3" = import ./1.5.3 { inherit lib stdenv ruby pkgs; };
    "1.5.6" = import ./1.5.6 { inherit lib stdenv ruby pkgs; };
    "1.6.1" = import ./1.6.1 { inherit lib stdenv ruby pkgs; };
    "1.6.2" = import ./1.6.2 { inherit lib stdenv ruby pkgs; };
    "1.6.3" = import ./1.6.3 { inherit lib stdenv ruby pkgs; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "pg: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "pg: unknown version '${version}'")
