#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cucumber-wire
#
# Versions: 6.2.1, 7.0.0, 8.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "8.0.0",
  git ? { },
}:
let
  versions = {
    "6.2.1" = import ./6.2.1 { inherit lib stdenv ruby; };
    "7.0.0" = import ./7.0.0 { inherit lib stdenv ruby; };
    "8.0.0" = import ./8.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "cucumber-wire: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "cucumber-wire: unknown version '${version}'")
