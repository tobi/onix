#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# commonmarker
#
# Versions: 0.23.10, 2.6.1, 2.6.2, 2.6.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.6.3",
  git ? { },
}:
let
  versions = {
    "0.23.10" = import ./0.23.10 { inherit lib stdenv ruby pkgs; };
    "2.6.1" = import ./2.6.1 { inherit lib stdenv ruby pkgs; };
    "2.6.2" = import ./2.6.2 { inherit lib stdenv ruby pkgs; };
    "2.6.3" = import ./2.6.3 { inherit lib stdenv ruby pkgs; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "commonmarker: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "commonmarker: unknown version '${version}'")
