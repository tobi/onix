#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# kaminari
#
# Versions: 1.2.0, 1.2.1, 1.2.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.2",
  git ? { },
}:
let
  versions = {
    "1.2.0" = import ./1.2.0 { inherit lib stdenv ruby; };
    "1.2.1" = import ./1.2.1 { inherit lib stdenv ruby; };
    "1.2.2" = import ./1.2.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "kaminari: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "kaminari: unknown version '${version}'")
