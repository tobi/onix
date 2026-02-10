#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# image_optim
#
# Versions: 0.31.4
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.31.4",
  git ? { },
}:
let
  versions = {
    "0.31.4" = import ./0.31.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "image_optim: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "image_optim: unknown version '${version}'")
