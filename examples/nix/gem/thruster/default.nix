#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# thruster
#
# Versions: 0.1.16, 0.1.17
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.1.17",
  git ? { },
}:
let
  versions = {
    "0.1.16" = import ./0.1.16 { inherit lib stdenv ruby; };
    "0.1.17" = import ./0.1.17 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "thruster: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "thruster: unknown version '${version}'")
