#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# warden
#
# Versions: 1.2.7, 1.2.8, 1.2.9
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.9",
  git ? { },
}:
let
  versions = {
    "1.2.7" = import ./1.2.7 { inherit lib stdenv ruby; };
    "1.2.8" = import ./1.2.8 { inherit lib stdenv ruby; };
    "1.2.9" = import ./1.2.9 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "warden: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "warden: unknown version '${version}'")
