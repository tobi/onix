#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# timers
#
# Versions: 4.3.4, 4.3.5, 4.4.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.4.0",
  git ? { },
}:
let
  versions = {
    "4.3.4" = import ./4.3.4 { inherit lib stdenv ruby; };
    "4.3.5" = import ./4.3.5 { inherit lib stdenv ruby; };
    "4.4.0" = import ./4.4.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "timers: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "timers: unknown version '${version}'")
