#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# state_machines-activerecord
#
# Versions: 0.9.0, 0.31.0, 0.40.0, 0.100.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.100.0",
  git ? { },
}:
let
  versions = {
    "0.9.0" = import ./0.9.0 { inherit lib stdenv ruby; };
    "0.31.0" = import ./0.31.0 { inherit lib stdenv ruby; };
    "0.40.0" = import ./0.40.0 { inherit lib stdenv ruby; };
    "0.100.0" = import ./0.100.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "state_machines-activerecord: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "state_machines-activerecord: unknown version '${version}'")
