#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# airbrake
#
# Versions: 13.0.3, 13.0.4, 13.0.5
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "13.0.5",
  git ? { },
}:
let
  versions = {
    "13.0.3" = import ./13.0.3 { inherit lib stdenv ruby; };
    "13.0.4" = import ./13.0.4 { inherit lib stdenv ruby; };
    "13.0.5" = import ./13.0.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "airbrake: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "airbrake: unknown version '${version}'")
