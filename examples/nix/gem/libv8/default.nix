#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# libv8
#
# Versions: 7.3.492.27.1, 8.4.255.0, 8.4.255.0.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "8.4.255.0.1",
  git ? { },
}:
let
  versions = {
    "7.3.492.27.1" = import ./7.3.492.27.1 { inherit lib stdenv ruby pkgs; };
    "8.4.255.0" = import ./8.4.255.0 { inherit lib stdenv ruby pkgs; };
    "8.4.255.0.1" = import ./8.4.255.0.1 { inherit lib stdenv ruby pkgs; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "libv8: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "libv8: unknown version '${version}'")
