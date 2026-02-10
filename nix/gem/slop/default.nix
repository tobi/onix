#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# slop
#
# Versions: 4.9.3, 4.10.0, 4.10.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.10.1",
  git ? { },
}:
let
  versions = {
    "4.9.3" = import ./4.9.3 { inherit lib stdenv ruby; };
    "4.10.0" = import ./4.10.0 { inherit lib stdenv ruby; };
    "4.10.1" = import ./4.10.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "slop: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "slop: unknown version '${version}'")
