#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# nap
#
# Versions: 0.8.0, 1.0.0, 1.1.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.1.0",
  git ? { },
}:
let
  versions = {
    "0.8.0" = import ./0.8.0 { inherit lib stdenv ruby; };
    "1.0.0" = import ./1.0.0 { inherit lib stdenv ruby; };
    "1.1.0" = import ./1.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "nap: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "nap: unknown version '${version}'")
