#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# babosa
#
# Versions: 1.0.3, 1.0.4, 2.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.0.0",
  git ? { },
}:
let
  versions = {
    "1.0.3" = import ./1.0.3 { inherit lib stdenv ruby; };
    "1.0.4" = import ./1.0.4 { inherit lib stdenv ruby; };
    "2.0.0" = import ./2.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "babosa: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "babosa: unknown version '${version}'")
