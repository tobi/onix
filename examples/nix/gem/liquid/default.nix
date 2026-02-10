#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# liquid
#
# Versions: 5.4.0, 5.9.0, 5.10.0, 5.11.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.11.0",
  git ? { },
}:
let
  versions = {
    "5.4.0" = import ./5.4.0 { inherit lib stdenv ruby; };
    "5.9.0" = import ./5.9.0 { inherit lib stdenv ruby; };
    "5.10.0" = import ./5.10.0 { inherit lib stdenv ruby; };
    "5.11.0" = import ./5.11.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "liquid: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "liquid: unknown version '${version}'")
