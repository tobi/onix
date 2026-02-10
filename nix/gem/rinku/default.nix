#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rinku
#
# Versions: 2.0.4, 2.0.5, 2.0.6
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.0.6",
  git ? { },
}:
let
  versions = {
    "2.0.4" = import ./2.0.4 { inherit lib stdenv ruby; };
    "2.0.5" = import ./2.0.5 { inherit lib stdenv ruby; };
    "2.0.6" = import ./2.0.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rinku: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rinku: unknown version '${version}'")
