#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# molinillo
#
# Versions: 0.6.6, 0.7.0, 0.8.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.8.0",
  git ? { },
}:
let
  versions = {
    "0.6.6" = import ./0.6.6 { inherit lib stdenv ruby; };
    "0.7.0" = import ./0.7.0 { inherit lib stdenv ruby; };
    "0.8.0" = import ./0.8.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "molinillo: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "molinillo: unknown version '${version}'")
