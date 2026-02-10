#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# counter_culture
#
# Versions: 3.5.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.5.3",
  git ? { },
}:
let
  versions = {
    "3.5.3" = import ./3.5.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "counter_culture: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "counter_culture: unknown version '${version}'")
