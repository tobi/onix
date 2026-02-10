#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# benchmark-ips
#
# Versions: 2.10.0, 2.12.0, 2.13.0, 2.14.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.14.0",
  git ? { },
}:
let
  versions = {
    "2.10.0" = import ./2.10.0 { inherit lib stdenv ruby; };
    "2.12.0" = import ./2.12.0 { inherit lib stdenv ruby; };
    "2.13.0" = import ./2.13.0 { inherit lib stdenv ruby; };
    "2.14.0" = import ./2.14.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "benchmark-ips: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "benchmark-ips: unknown version '${version}'")
