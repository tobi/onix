#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# image_size
#
# Versions: 3.4.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.4.0",
  git ? { },
}:
let
  versions = {
    "3.4.0" = import ./3.4.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "image_size: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "image_size: unknown version '${version}'")
