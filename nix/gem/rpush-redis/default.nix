#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rpush-redis
#
# Versions: 1.2.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.0",
  git ? { },
}:
let
  versions = {
    "1.2.0" = import ./1.2.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rpush-redis: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rpush-redis: unknown version '${version}'")
