#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ethon
#
# Versions: 0.16.0, 0.17.0, 0.18.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.18.0",
  git ? { },
}:
let
  versions = {
    "0.16.0" = import ./0.16.0 { inherit lib stdenv ruby; };
    "0.17.0" = import ./0.17.0 { inherit lib stdenv ruby; };
    "0.18.0" = import ./0.18.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ethon: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "ethon: unknown version '${version}'")
