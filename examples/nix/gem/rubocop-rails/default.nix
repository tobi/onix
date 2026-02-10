#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop-rails
#
# Versions: 2.24.1, 2.30.3, 2.32.0, 2.33.4, 2.34.0, 2.34.1, 2.34.2, 2.34.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.34.3",
  git ? { },
}:
let
  versions = {
    "2.24.1" = import ./2.24.1 { inherit lib stdenv ruby; };
    "2.30.3" = import ./2.30.3 { inherit lib stdenv ruby; };
    "2.32.0" = import ./2.32.0 { inherit lib stdenv ruby; };
    "2.33.4" = import ./2.33.4 { inherit lib stdenv ruby; };
    "2.34.0" = import ./2.34.0 { inherit lib stdenv ruby; };
    "2.34.1" = import ./2.34.1 { inherit lib stdenv ruby; };
    "2.34.2" = import ./2.34.2 { inherit lib stdenv ruby; };
    "2.34.3" = import ./2.34.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rubocop-rails: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rubocop-rails: unknown version '${version}'")
