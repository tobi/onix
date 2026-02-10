#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# json_pure
#
# Versions: 2.7.6, 2.8.0, 2.8.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.8.1",
  git ? { },
}:
let
  versions = {
    "2.7.6" = import ./2.7.6 { inherit lib stdenv ruby; };
    "2.8.0" = import ./2.8.0 { inherit lib stdenv ruby; };
    "2.8.1" = import ./2.8.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "json_pure: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "json_pure: unknown version '${version}'")
