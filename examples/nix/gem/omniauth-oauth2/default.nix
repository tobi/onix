#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# omniauth-oauth2
#
# Versions: 1.7.3, 1.8.0, 1.9.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.9.0",
  git ? { },
}:
let
  versions = {
    "1.7.3" = import ./1.7.3 { inherit lib stdenv ruby; };
    "1.8.0" = import ./1.8.0 { inherit lib stdenv ruby; };
    "1.9.0" = import ./1.9.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "omniauth-oauth2: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "omniauth-oauth2: unknown version '${version}'")
