#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# state_machines-activemodel
#
# Versions: 0.9.0, 0.31.2, 0.100.0, 0.101.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.101.0",
  git ? { },
}:
let
  versions = {
    "0.9.0" = import ./0.9.0 { inherit lib stdenv ruby; };
    "0.31.2" = import ./0.31.2 { inherit lib stdenv ruby; };
    "0.100.0" = import ./0.100.0 { inherit lib stdenv ruby; };
    "0.101.0" = import ./0.101.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "state_machines-activemodel: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "state_machines-activemodel: unknown version '${version}'")
