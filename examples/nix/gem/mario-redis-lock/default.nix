#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mario-redis-lock
#
# Versions: 1.2.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.1",
  git ? { },
}:
let
  versions = {
    "1.2.1" = import ./1.2.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mario-redis-lock: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "mario-redis-lock: unknown version '${version}'")
