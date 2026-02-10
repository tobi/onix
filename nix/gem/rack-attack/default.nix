#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rack-attack
#
# Versions: 6.6.1, 6.7.0, 6.8.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.8.0",
  git ? { },
}:
let
  versions = {
    "6.6.1" = import ./6.6.1 { inherit lib stdenv ruby; };
    "6.7.0" = import ./6.7.0 { inherit lib stdenv ruby; };
    "6.8.0" = import ./6.8.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rack-attack: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rack-attack: unknown version '${version}'")
