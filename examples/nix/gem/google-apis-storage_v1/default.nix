#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# google-apis-storage_v1
#
# Versions: 0.47.0, 0.49.0, 0.58.0, 0.59.0, 0.60.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.60.0",
  git ? { },
}:
let
  versions = {
    "0.47.0" = import ./0.47.0 { inherit lib stdenv ruby; };
    "0.49.0" = import ./0.49.0 { inherit lib stdenv ruby; };
    "0.58.0" = import ./0.58.0 { inherit lib stdenv ruby; };
    "0.59.0" = import ./0.59.0 { inherit lib stdenv ruby; };
    "0.60.0" = import ./0.60.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "google-apis-storage_v1: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "google-apis-storage_v1: unknown version '${version}'")
