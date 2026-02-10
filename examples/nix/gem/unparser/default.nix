#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# unparser
#
# Versions: 0.7.0, 0.8.0, 0.8.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.8.1",
  git ? { },
}:
let
  versions = {
    "0.7.0" = import ./0.7.0 { inherit lib stdenv ruby; };
    "0.8.0" = import ./0.8.0 { inherit lib stdenv ruby; };
    "0.8.1" = import ./0.8.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "unparser: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "unparser: unknown version '${version}'")
