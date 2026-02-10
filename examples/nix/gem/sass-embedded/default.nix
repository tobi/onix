#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sass-embedded
#
# Versions: 1.83.4, 1.91.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.91.0",
  git ? { },
}:
let
  versions = {
    "1.83.4" = import ./1.83.4 { inherit lib stdenv ruby; };
    "1.91.0" = import ./1.91.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sass-embedded: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "sass-embedded: unknown version '${version}'")
