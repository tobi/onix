#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# geocoder
#
# Versions: 1.8.1, 1.8.4, 1.8.5, 1.8.6
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.8.6",
  git ? { },
}:
let
  versions = {
    "1.8.1" = import ./1.8.1 { inherit lib stdenv ruby; };
    "1.8.4" = import ./1.8.4 { inherit lib stdenv ruby; };
    "1.8.5" = import ./1.8.5 { inherit lib stdenv ruby; };
    "1.8.6" = import ./1.8.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "geocoder: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "geocoder: unknown version '${version}'")
