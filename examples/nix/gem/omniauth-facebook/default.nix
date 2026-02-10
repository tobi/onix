#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# omniauth-facebook
#
# Versions: 8.0.0, 9.0.0, 10.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "10.0.0",
  git ? { },
}:
let
  versions = {
    "8.0.0" = import ./8.0.0 { inherit lib stdenv ruby; };
    "9.0.0" = import ./9.0.0 { inherit lib stdenv ruby; };
    "10.0.0" = import ./10.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "omniauth-facebook: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "omniauth-facebook: unknown version '${version}'")
