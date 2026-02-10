#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# openssl
#
# Versions: 3.2.0, 3.3.1, 3.3.2, 4.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.0.0",
  git ? { },
}:
let
  versions = {
    "3.2.0" = import ./3.2.0 { inherit lib stdenv ruby pkgs; };
    "3.3.1" = import ./3.3.1 { inherit lib stdenv ruby pkgs; };
    "3.3.2" = import ./3.3.2 { inherit lib stdenv ruby pkgs; };
    "4.0.0" = import ./4.0.0 { inherit lib stdenv ruby pkgs; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "openssl: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "openssl: unknown version '${version}'")
