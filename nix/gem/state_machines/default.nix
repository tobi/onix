#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# state_machines
#
# Versions: 0.6.0, 0.100.1, 0.100.2, 0.100.4
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.100.4",
  git ? { },
}:
let
  versions = {
    "0.6.0" = import ./0.6.0 { inherit lib stdenv ruby; };
    "0.100.1" = import ./0.100.1 { inherit lib stdenv ruby; };
    "0.100.2" = import ./0.100.2 { inherit lib stdenv ruby; };
    "0.100.4" = import ./0.100.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "state_machines: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "state_machines: unknown version '${version}'")
