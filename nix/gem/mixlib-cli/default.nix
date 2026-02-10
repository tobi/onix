#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mixlib-cli
#
# Versions: 2.1.5, 2.1.6, 2.1.8
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.1.8",
  git ? { },
}:
let
  versions = {
    "2.1.5" = import ./2.1.5 { inherit lib stdenv ruby; };
    "2.1.6" = import ./2.1.6 { inherit lib stdenv ruby; };
    "2.1.8" = import ./2.1.8 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mixlib-cli: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "mixlib-cli: unknown version '${version}'")
