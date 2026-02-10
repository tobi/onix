#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# gpgme
#
# Versions: 2.0.23, 2.0.24, 2.0.25
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.0.25",
  git ? { },
}:
let
  versions = {
    "2.0.23" = import ./2.0.23 { inherit lib stdenv ruby pkgs; };
    "2.0.24" = import ./2.0.24 { inherit lib stdenv ruby pkgs; };
    "2.0.25" = import ./2.0.25 { inherit lib stdenv ruby pkgs; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "gpgme: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "gpgme: unknown version '${version}'")
