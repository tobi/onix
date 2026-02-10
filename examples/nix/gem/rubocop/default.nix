#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop
#
# Versions: 1.63.4, 1.75.6, 1.79.2, 1.81.7, 1.82.1, 1.84.0, 1.84.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.84.1",
  git ? { },
}:
let
  versions = {
    "1.63.4" = import ./1.63.4 { inherit lib stdenv ruby; };
    "1.75.6" = import ./1.75.6 { inherit lib stdenv ruby; };
    "1.79.2" = import ./1.79.2 { inherit lib stdenv ruby; };
    "1.81.7" = import ./1.81.7 { inherit lib stdenv ruby; };
    "1.82.1" = import ./1.82.1 { inherit lib stdenv ruby; };
    "1.84.0" = import ./1.84.0 { inherit lib stdenv ruby; };
    "1.84.1" = import ./1.84.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rubocop: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rubocop: unknown version '${version}'")
