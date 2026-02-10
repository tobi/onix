#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# redis-actionpack
#
# Versions: 5.3.0, 5.4.0, 5.5.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.5.0",
  git ? { },
}:
let
  versions = {
    "5.3.0" = import ./5.3.0 { inherit lib stdenv ruby; };
    "5.4.0" = import ./5.4.0 { inherit lib stdenv ruby; };
    "5.5.0" = import ./5.5.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "redis-actionpack: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "redis-actionpack: unknown version '${version}'")
