#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# nio4r
#
# Versions: 2.7.0, 2.7.3, 2.7.4, 2.7.5
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.7.5",
  git ? { },
}:
let
  versions = {
    "2.7.0" = import ./2.7.0 { inherit lib stdenv ruby; };
    "2.7.3" = import ./2.7.3 { inherit lib stdenv ruby; };
    "2.7.4" = import ./2.7.4 { inherit lib stdenv ruby; };
    "2.7.5" = import ./2.7.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "nio4r: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "nio4r: unknown version '${version}'")
