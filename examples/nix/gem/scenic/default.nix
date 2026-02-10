#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# scenic
#
# Versions: 1.9.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.9.0",
  git ? { },
}:
let
  versions = {
    "1.9.0" = import ./1.9.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "scenic: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "scenic: unknown version '${version}'")
