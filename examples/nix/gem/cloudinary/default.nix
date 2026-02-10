#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cloudinary
#
# Versions: 1.29.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.29.0",
  git ? { },
}:
let
  versions = {
    "1.29.0" = import ./1.29.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "cloudinary: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "cloudinary: unknown version '${version}'")
