#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# squasher
#
# Versions: 0.7.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.7.2",
  git ? { },
}:
let
  versions = {
    "0.7.2" = import ./0.7.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "squasher: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "squasher: unknown version '${version}'")
