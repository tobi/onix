#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# raindrops
#
# Versions: 0.19.2, 0.20.0, 0.20.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.20.1",
  git ? { },
}:
let
  versions = {
    "0.19.2" = import ./0.19.2 { inherit lib stdenv ruby; };
    "0.20.0" = import ./0.20.0 { inherit lib stdenv ruby; };
    "0.20.1" = import ./0.20.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "raindrops: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "raindrops: unknown version '${version}'")
