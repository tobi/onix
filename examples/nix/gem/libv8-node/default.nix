#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# libv8-node
#
# Versions: 24.1.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "24.1.0.0",
  git ? { },
}:
let
  versions = {
    "24.1.0.0" = import ./24.1.0.0 { inherit lib stdenv ruby pkgs; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "libv8-node: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "libv8-node: unknown version '${version}'")
