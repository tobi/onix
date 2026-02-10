#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# literate_randomizer
#
# Versions: 0.4.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.4.0",
  git ? { },
}:
let
  versions = {
    "0.4.0" = import ./0.4.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "literate_randomizer: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "literate_randomizer: unknown version '${version}'")
