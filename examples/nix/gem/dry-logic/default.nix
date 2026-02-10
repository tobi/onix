#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# dry-logic
#
# Versions: 1.4.0, 1.5.0, 1.6.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.6.0",
  git ? { },
}:
let
  versions = {
    "1.4.0" = import ./1.4.0 { inherit lib stdenv ruby; };
    "1.5.0" = import ./1.5.0 { inherit lib stdenv ruby; };
    "1.6.0" = import ./1.6.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "dry-logic: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "dry-logic: unknown version '${version}'")
