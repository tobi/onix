#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mysql2
#
# Versions: 0.5.5, 0.5.6, 0.5.7
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.5.7",
  git ? { },
}:
let
  versions = {
    "0.5.5" = import ./0.5.5 { inherit lib stdenv ruby pkgs; };
    "0.5.6" = import ./0.5.6 { inherit lib stdenv ruby pkgs; };
    "0.5.7" = import ./0.5.7 { inherit lib stdenv ruby pkgs; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mysql2: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "mysql2: unknown version '${version}'")
