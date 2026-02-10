#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# nesty
#
# Versions: 1.0.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.2",
  git ? { },
}:
let
  versions = {
    "1.0.2" = import ./1.0.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "nesty: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "nesty: unknown version '${version}'")
