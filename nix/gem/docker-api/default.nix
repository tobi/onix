#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# docker-api
#
# Versions: 2.2.0, 2.3.0, 2.4.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.4.0",
  git ? { },
}:
let
  versions = {
    "2.2.0" = import ./2.2.0 { inherit lib stdenv ruby; };
    "2.3.0" = import ./2.3.0 { inherit lib stdenv ruby; };
    "2.4.0" = import ./2.4.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "docker-api: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "docker-api: unknown version '${version}'")
