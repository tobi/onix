#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# test-unit
#
# Versions: 3.7.5, 3.7.6, 3.7.7
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.7.7",
  git ? { },
}:
let
  versions = {
    "3.7.5" = import ./3.7.5 { inherit lib stdenv ruby; };
    "3.7.6" = import ./3.7.6 { inherit lib stdenv ruby; };
    "3.7.7" = import ./3.7.7 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "test-unit: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "test-unit: unknown version '${version}'")
