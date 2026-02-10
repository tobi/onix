#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# algolia
#
# Versions: 2.3.4
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.3.4",
  git ? { },
}:
let
  versions = {
    "2.3.4" = import ./2.3.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "algolia: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "algolia: unknown version '${version}'")
