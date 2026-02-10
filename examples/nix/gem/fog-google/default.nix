#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fog-google
#
# Versions: 1.29.1, 1.29.2, 1.29.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.29.3",
  git ? { },
}:
let
  versions = {
    "1.29.1" = import ./1.29.1 { inherit lib stdenv ruby; };
    "1.29.2" = import ./1.29.2 { inherit lib stdenv ruby; };
    "1.29.3" = import ./1.29.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "fog-google: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "fog-google: unknown version '${version}'")
