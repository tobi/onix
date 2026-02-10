#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ffaker
#
# Versions: 2.23.0, 2.24.0, 2.25.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.25.0",
  git ? { },
}:
let
  versions = {
    "2.23.0" = import ./2.23.0 { inherit lib stdenv ruby; };
    "2.24.0" = import ./2.24.0 { inherit lib stdenv ruby; };
    "2.25.0" = import ./2.25.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ffaker: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "ffaker: unknown version '${version}'")
