#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tracking_number
#
# Versions: 2.4.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.4.0",
  git ? { },
}:
let
  versions = {
    "2.4.0" = import ./2.4.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "tracking_number: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "tracking_number: unknown version '${version}'")
