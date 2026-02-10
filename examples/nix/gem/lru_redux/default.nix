#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# lru_redux
#
# Versions: 0.8.3, 0.8.4, 1.1.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.1.0",
  git ? { },
}:
let
  versions = {
    "0.8.3" = import ./0.8.3 { inherit lib stdenv ruby; };
    "0.8.4" = import ./0.8.4 { inherit lib stdenv ruby; };
    "1.1.0" = import ./1.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "lru_redux: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "lru_redux: unknown version '${version}'")
