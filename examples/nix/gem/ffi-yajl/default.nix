#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ffi-yajl
#
# Versions: 2.7.6, 2.7.7, 3.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.0.0",
  git ? { },
}:
let
  versions = {
    "2.7.6" = import ./2.7.6 { inherit lib stdenv ruby pkgs; };
    "2.7.7" = import ./2.7.7 { inherit lib stdenv ruby pkgs; };
    "3.0.0" = import ./3.0.0 { inherit lib stdenv ruby pkgs; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ffi-yajl: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "ffi-yajl: unknown version '${version}'")
