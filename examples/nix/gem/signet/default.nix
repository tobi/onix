#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# signet
#
# Versions: 0.17.0, 0.19.0, 0.20.0, 0.21.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.21.0",
  git ? { },
}:
let
  versions = {
    "0.17.0" = import ./0.17.0 { inherit lib stdenv ruby; };
    "0.19.0" = import ./0.19.0 { inherit lib stdenv ruby; };
    "0.20.0" = import ./0.20.0 { inherit lib stdenv ruby; };
    "0.21.0" = import ./0.21.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "signet: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "signet: unknown version '${version}'")
