#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ice_nine
#
# Versions: 0.11.1, 0.11.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.11.2",
  git ? { },
}:
let
  versions = {
    "0.11.1" = import ./0.11.1 { inherit lib stdenv ruby; };
    "0.11.2" = import ./0.11.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ice_nine: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "ice_nine: unknown version '${version}'")
