#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cocoapods
#
# Versions: 1.16.0, 1.16.1, 1.16.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.16.2",
  git ? { },
}:
let
  versions = {
    "1.16.0" = import ./1.16.0 { inherit lib stdenv ruby; };
    "1.16.1" = import ./1.16.1 { inherit lib stdenv ruby; };
    "1.16.2" = import ./1.16.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "cocoapods: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "cocoapods: unknown version '${version}'")
