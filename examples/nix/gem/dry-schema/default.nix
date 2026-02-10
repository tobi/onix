#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# dry-schema
#
# Versions: 1.14.0, 1.14.1, 1.15.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.15.0",
  git ? { },
}:
let
  versions = {
    "1.14.0" = import ./1.14.0 { inherit lib stdenv ruby; };
    "1.14.1" = import ./1.14.1 { inherit lib stdenv ruby; };
    "1.15.0" = import ./1.15.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "dry-schema: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "dry-schema: unknown version '${version}'")
