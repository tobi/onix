#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mock_redis
#
# Versions: 0.36.0, 0.51.0, 0.52.0, 0.53.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.53.0",
  git ? { },
}:
let
  versions = {
    "0.36.0" = import ./0.36.0 { inherit lib stdenv ruby; };
    "0.51.0" = import ./0.51.0 { inherit lib stdenv ruby; };
    "0.52.0" = import ./0.52.0 { inherit lib stdenv ruby; };
    "0.53.0" = import ./0.53.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mock_redis: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "mock_redis: unknown version '${version}'")
