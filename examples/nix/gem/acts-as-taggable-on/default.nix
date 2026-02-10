#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# acts-as-taggable-on
#
# Versions: 10.0.0, 11.0.0, 12.0.0, 13.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "13.0.0",
  git ? { },
}:
let
  versions = {
    "10.0.0" = import ./10.0.0 { inherit lib stdenv ruby; };
    "11.0.0" = import ./11.0.0 { inherit lib stdenv ruby; };
    "12.0.0" = import ./12.0.0 { inherit lib stdenv ruby; };
    "13.0.0" = import ./13.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "acts-as-taggable-on: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "acts-as-taggable-on: unknown version '${version}'")
