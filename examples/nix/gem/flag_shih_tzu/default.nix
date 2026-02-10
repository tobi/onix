#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# flag_shih_tzu
#
# Versions: 0.3.23
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.3.23",
  git ? { },
}:
let
  versions = {
    "0.3.23" = import ./0.3.23 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "flag_shih_tzu: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "flag_shih_tzu: unknown version '${version}'")
