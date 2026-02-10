#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# extralite-bundle
#
# Versions: 2.13
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.13",
  git ? { },
}:
let
  versions = {
    "2.13" = import ./2.13 { inherit lib stdenv ruby pkgs; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "extralite-bundle: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "extralite-bundle: unknown version '${version}'")
