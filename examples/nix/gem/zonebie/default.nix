#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# zonebie
#
# Versions: 0.6.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.6.1",
  git ? { },
}:
let
  versions = {
    "0.6.1" = import ./0.6.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "zonebie: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "zonebie: unknown version '${version}'")
