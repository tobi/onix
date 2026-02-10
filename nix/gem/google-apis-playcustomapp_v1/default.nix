#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# google-apis-playcustomapp_v1
#
# Versions: 0.15.0, 0.16.0, 0.17.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.17.0",
  git ? { },
}:
let
  versions = {
    "0.15.0" = import ./0.15.0 { inherit lib stdenv ruby; };
    "0.16.0" = import ./0.16.0 { inherit lib stdenv ruby; };
    "0.17.0" = import ./0.17.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "google-apis-playcustomapp_v1: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "google-apis-playcustomapp_v1: unknown version '${version}'")
