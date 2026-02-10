#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# spring
#
# Versions: 4.1.1, 4.4.0, 4.4.1, 4.4.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.4.2",
  git ? { },
}:
let
  versions = {
    "4.1.1" = import ./4.1.1 { inherit lib stdenv ruby; };
    "4.4.0" = import ./4.4.0 { inherit lib stdenv ruby; };
    "4.4.1" = import ./4.4.1 { inherit lib stdenv ruby; };
    "4.4.2" = import ./4.4.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "spring: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "spring: unknown version '${version}'")
