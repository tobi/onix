#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# simctl
#
# Versions: 1.6.7, 1.6.8, 1.6.10
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.6.10",
  git ? { },
}:
let
  versions = {
    "1.6.7" = import ./1.6.7 { inherit lib stdenv ruby; };
    "1.6.8" = import ./1.6.8 { inherit lib stdenv ruby; };
    "1.6.10" = import ./1.6.10 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "simctl: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "simctl: unknown version '${version}'")
