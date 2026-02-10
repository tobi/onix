#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# json-jwt
#
# Versions: 1.16.6, 1.16.7, 1.17.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.17.0",
  git ? { },
}:
let
  versions = {
    "1.16.6" = import ./1.16.6 { inherit lib stdenv ruby; };
    "1.16.7" = import ./1.16.7 { inherit lib stdenv ruby; };
    "1.17.0" = import ./1.17.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "json-jwt: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "json-jwt: unknown version '${version}'")
