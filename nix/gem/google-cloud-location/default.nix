#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# google-cloud-location
#
# Versions: 0.6.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.6.0",
  git ? { },
}:
let
  versions = {
    "0.6.0" = import ./0.6.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "google-cloud-location: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "google-cloud-location: unknown version '${version}'")
