#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# algoliasearch
#
# Versions: 1.27.3, 1.27.4, 1.27.5
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.27.5",
  git ? { },
}:
let
  versions = {
    "1.27.3" = import ./1.27.3 { inherit lib stdenv ruby; };
    "1.27.4" = import ./1.27.4 { inherit lib stdenv ruby; };
    "1.27.5" = import ./1.27.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "algoliasearch: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "algoliasearch: unknown version '${version}'")
