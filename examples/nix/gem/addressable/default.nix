#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# addressable
#
# Versions: 2.8.6, 2.8.7, 2.8.8
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.8.8",
  git ? { },
}:
let
  versions = {
    "2.8.6" = import ./2.8.6 { inherit lib stdenv ruby; };
    "2.8.7" = import ./2.8.7 { inherit lib stdenv ruby; };
    "2.8.8" = import ./2.8.8 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "addressable: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "addressable: unknown version '${version}'")
