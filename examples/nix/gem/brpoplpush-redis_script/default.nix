#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# brpoplpush-redis_script
#
# Versions: 0.1.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.1.3",
  git ? { },
}:
let
  versions = {
    "0.1.3" = import ./0.1.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "brpoplpush-redis_script: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "brpoplpush-redis_script: unknown version '${version}'")
