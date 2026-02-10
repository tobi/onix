#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# linzer
#
# Versions: 0.7.7
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.7.7",
  git ? { },
}:
let
  versions = {
    "0.7.7" = import ./0.7.7 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "linzer: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "linzer: unknown version '${version}'")
