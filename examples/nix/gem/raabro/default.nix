#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# raabro
#
# Versions: 1.3.2, 1.3.3, 1.4.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.4.0",
  git ? { },
}:
let
  versions = {
    "1.3.2" = import ./1.3.2 { inherit lib stdenv ruby; };
    "1.3.3" = import ./1.3.3 { inherit lib stdenv ruby; };
    "1.4.0" = import ./1.4.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "raabro: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "raabro: unknown version '${version}'")
