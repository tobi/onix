#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# digest-crc
#
# Versions: 0.6.4, 0.6.5, 0.7.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.7.0",
  git ? { },
}:
let
  versions = {
    "0.6.4" = import ./0.6.4 { inherit lib stdenv ruby; };
    "0.6.5" = import ./0.6.5 { inherit lib stdenv ruby; };
    "0.7.0" = import ./0.7.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "digest-crc: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "digest-crc: unknown version '${version}'")
