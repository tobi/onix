#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fastlane
#
# Versions: 2.231.0, 2.231.1, 2.232.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.232.0",
  git ? { },
}:
let
  versions = {
    "2.231.0" = import ./2.231.0 { inherit lib stdenv ruby; };
    "2.231.1" = import ./2.231.1 { inherit lib stdenv ruby; };
    "2.232.0" = import ./2.232.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "fastlane: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "fastlane: unknown version '${version}'")
