#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# dry-types
#
# Versions: 1.8.3, 1.9.0, 1.9.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.9.1",
  git ? { },
}:
let
  versions = {
    "1.8.3" = import ./1.8.3 { inherit lib stdenv ruby; };
    "1.9.0" = import ./1.9.0 { inherit lib stdenv ruby; };
    "1.9.1" = import ./1.9.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "dry-types: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "dry-types: unknown version '${version}'")
