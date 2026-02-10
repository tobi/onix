#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# image_processing
#
# Versions: 1.12.2, 1.13.0, 1.14.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.14.0",
  git ? { },
}:
let
  versions = {
    "1.12.2" = import ./1.12.2 { inherit lib stdenv ruby; };
    "1.13.0" = import ./1.13.0 { inherit lib stdenv ruby; };
    "1.14.0" = import ./1.14.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "image_processing: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "image_processing: unknown version '${version}'")
