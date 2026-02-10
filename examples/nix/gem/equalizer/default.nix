#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# equalizer
#
# Versions: 0.0.9, 0.0.11
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.0.11",
  git ? { },
}:
let
  versions = {
    "0.0.9" = import ./0.0.9 { inherit lib stdenv ruby; };
    "0.0.11" = import ./0.0.11 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "equalizer: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "equalizer: unknown version '${version}'")
