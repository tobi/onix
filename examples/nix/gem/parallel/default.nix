#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# parallel
#
# Versions: 1.24.0, 1.26.2, 1.26.3, 1.27.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.27.0",
  git ? { },
}:
let
  versions = {
    "1.24.0" = import ./1.24.0 { inherit lib stdenv ruby; };
    "1.26.2" = import ./1.26.2 { inherit lib stdenv ruby; };
    "1.26.3" = import ./1.26.3 { inherit lib stdenv ruby; };
    "1.27.0" = import ./1.27.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "parallel: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "parallel: unknown version '${version}'")
