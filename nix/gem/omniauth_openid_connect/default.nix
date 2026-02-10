#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# omniauth_openid_connect
#
# Versions: 0.8.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.8.0",
  git ? { },
}:
let
  versions = {
    "0.8.0" = import ./0.8.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "omniauth_openid_connect: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "omniauth_openid_connect: unknown version '${version}'")
