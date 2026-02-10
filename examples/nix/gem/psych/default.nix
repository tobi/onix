#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# psych
#
# Versions: 5.1.2, 5.2.6, 5.3.0, 5.3.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.3.1",
  git ? { },
}:
let
  versions = {
    "5.1.2" = import ./5.1.2 { inherit lib stdenv ruby pkgs; };
    "5.2.6" = import ./5.2.6 { inherit lib stdenv ruby pkgs; };
    "5.3.0" = import ./5.3.0 { inherit lib stdenv ruby pkgs; };
    "5.3.1" = import ./5.3.1 { inherit lib stdenv ruby pkgs; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "psych: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "psych: unknown version '${version}'")
