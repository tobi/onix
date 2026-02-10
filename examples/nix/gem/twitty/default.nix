#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# twitty
#
# Versions: 0.1.5
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.1.5",
  git ? { },
}:
let
  versions = {
    "0.1.5" = import ./0.1.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "twitty: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "twitty: unknown version '${version}'")
