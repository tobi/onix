#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# prawn
#
# Versions: 2.3.0, 2.4.0, 2.5.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.5.0",
  git ? { },
}:
let
  versions = {
    "2.3.0" = import ./2.3.0 { inherit lib stdenv ruby; };
    "2.4.0" = import ./2.4.0 { inherit lib stdenv ruby; };
    "2.5.0" = import ./2.5.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "prawn: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "prawn: unknown version '${version}'")
