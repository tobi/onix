#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# flickwerk
#
# Versions: 0.3.6
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.3.6",
  git ? { },
}:
let
  versions = {
    "0.3.6" = import ./0.3.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "flickwerk: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "flickwerk: unknown version '${version}'")
