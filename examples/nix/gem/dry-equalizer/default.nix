#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# dry-equalizer
#
# Versions: 0.2.1, 0.2.2, 0.3.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.3.0",
  git ? { },
}:
let
  versions = {
    "0.2.1" = import ./0.2.1 { inherit lib stdenv ruby; };
    "0.2.2" = import ./0.2.2 { inherit lib stdenv ruby; };
    "0.3.0" = import ./0.3.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "dry-equalizer: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "dry-equalizer: unknown version '${version}'")
