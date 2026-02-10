#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# dry-container
#
# Versions: 0.10.0, 0.10.1, 0.11.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.11.0",
  git ? { },
}:
let
  versions = {
    "0.10.0" = import ./0.10.0 { inherit lib stdenv ruby; };
    "0.10.1" = import ./0.10.1 { inherit lib stdenv ruby; };
    "0.11.0" = import ./0.11.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "dry-container: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "dry-container: unknown version '${version}'")
