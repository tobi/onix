#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# progress
#
# Versions: 3.6.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.6.0",
  git ? { },
}:
let
  versions = {
    "3.6.0" = import ./3.6.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "progress: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "progress: unknown version '${version}'")
