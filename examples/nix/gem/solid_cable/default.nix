#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# solid_cable
#
# Versions: 3.0.5, 3.0.12
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.0.12",
  git ? { },
}:
let
  versions = {
    "3.0.5" = import ./3.0.5 { inherit lib stdenv ruby; };
    "3.0.12" = import ./3.0.12 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "solid_cable: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "solid_cable: unknown version '${version}'")
