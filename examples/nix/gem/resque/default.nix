#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# resque
#
# Versions: 2.6.0, 2.7.0, 3.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.0.0",
  git ? { },
}:
let
  versions = {
    "2.6.0" = import ./2.6.0 { inherit lib stdenv ruby; };
    "2.7.0" = import ./2.7.0 { inherit lib stdenv ruby; };
    "3.0.0" = import ./3.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "resque: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "resque: unknown version '${version}'")
