#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# dry-core
#
# Versions: 1.0.2, 1.1.0, 1.2.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.0",
  git ? { },
}:
let
  versions = {
    "1.0.2" = import ./1.0.2 { inherit lib stdenv ruby; };
    "1.1.0" = import ./1.1.0 { inherit lib stdenv ruby; };
    "1.2.0" = import ./1.2.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "dry-core: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "dry-core: unknown version '${version}'")
