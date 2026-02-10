#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# omnes
#
# Versions: 0.2.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.2.3",
  git ? { },
}:
let
  versions = {
    "0.2.3" = import ./0.2.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "omnes: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "omnes: unknown version '${version}'")
