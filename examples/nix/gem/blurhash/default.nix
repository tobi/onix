#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# blurhash
#
# Versions: 0.1.8
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.1.8",
  git ? { },
}:
let
  versions = {
    "0.1.8" = import ./0.1.8 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "blurhash: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "blurhash: unknown version '${version}'")
