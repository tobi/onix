#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop-ast
#
# Versions: 1.31.2, 1.44.1, 1.46.0, 1.47.1, 1.48.0, 1.49.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.49.0",
  git ? { },
}:
let
  versions = {
    "1.31.2" = import ./1.31.2 { inherit lib stdenv ruby; };
    "1.44.1" = import ./1.44.1 { inherit lib stdenv ruby; };
    "1.46.0" = import ./1.46.0 { inherit lib stdenv ruby; };
    "1.47.1" = import ./1.47.1 { inherit lib stdenv ruby; };
    "1.48.0" = import ./1.48.0 { inherit lib stdenv ruby; };
    "1.49.0" = import ./1.49.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rubocop-ast: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rubocop-ast: unknown version '${version}'")
