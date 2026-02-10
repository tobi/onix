#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# openid_connect
#
# Versions: 2.2.1, 2.3.0, 2.3.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.3.1",
  git ? { },
}:
let
  versions = {
    "2.2.1" = import ./2.2.1 { inherit lib stdenv ruby; };
    "2.3.0" = import ./2.3.0 { inherit lib stdenv ruby; };
    "2.3.1" = import ./2.3.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "openid_connect: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "openid_connect: unknown version '${version}'")
