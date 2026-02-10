#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# gon
#
# Versions: 6.5.0, 6.6.0, 7.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "7.0.0",
  git ? { },
}:
let
  versions = {
    "6.5.0" = import ./6.5.0 { inherit lib stdenv ruby; };
    "6.6.0" = import ./6.6.0 { inherit lib stdenv ruby; };
    "7.0.0" = import ./7.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "gon: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "gon: unknown version '${version}'")
