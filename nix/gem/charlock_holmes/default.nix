#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# charlock_holmes
#
# Versions: 0.7.7, 0.7.8, 0.7.9
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.7.9",
  git ? { },
}:
let
  versions = {
    "0.7.7" = import ./0.7.7 { inherit lib stdenv ruby pkgs; };
    "0.7.8" = import ./0.7.8 { inherit lib stdenv ruby pkgs; };
    "0.7.9" = import ./0.7.9 { inherit lib stdenv ruby pkgs; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "charlock_holmes: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "charlock_holmes: unknown version '${version}'")
