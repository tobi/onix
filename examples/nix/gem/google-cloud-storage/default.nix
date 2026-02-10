#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# google-cloud-storage
#
# Versions: 1.52.0, 1.54.0, 1.57.0, 1.57.1, 1.58.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.58.0",
  git ? { },
}:
let
  versions = {
    "1.52.0" = import ./1.52.0 { inherit lib stdenv ruby; };
    "1.54.0" = import ./1.54.0 { inherit lib stdenv ruby; };
    "1.57.0" = import ./1.57.0 { inherit lib stdenv ruby; };
    "1.57.1" = import ./1.57.1 { inherit lib stdenv ruby; };
    "1.58.0" = import ./1.58.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "google-cloud-storage: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "google-cloud-storage: unknown version '${version}'")
