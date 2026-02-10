#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cocoapods-deintegrate
#
# Versions: 1.0.3, 1.0.4, 1.0.5
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.5",
  git ? { },
}:
let
  versions = {
    "1.0.3" = import ./1.0.3 { inherit lib stdenv ruby; };
    "1.0.4" = import ./1.0.4 { inherit lib stdenv ruby; };
    "1.0.5" = import ./1.0.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "cocoapods-deintegrate: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "cocoapods-deintegrate: unknown version '${version}'")
