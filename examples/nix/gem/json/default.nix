#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# json
#
# Versions: 2.7.2, 2.13.2, 2.15.2, 2.17.1, 2.18.0, 2.18.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.18.1",
  git ? { },
}:
let
  versions = {
    "2.7.2" = import ./2.7.2 { inherit lib stdenv ruby; };
    "2.13.2" = import ./2.13.2 { inherit lib stdenv ruby; };
    "2.15.2" = import ./2.15.2 { inherit lib stdenv ruby; };
    "2.17.1" = import ./2.17.1 { inherit lib stdenv ruby; };
    "2.18.0" = import ./2.18.0 { inherit lib stdenv ruby; };
    "2.18.1" = import ./2.18.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "json: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "json: unknown version '${version}'")
