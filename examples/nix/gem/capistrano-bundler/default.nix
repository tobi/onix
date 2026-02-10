#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# capistrano-bundler
#
# Versions: 2.1.0, 2.1.1, 2.2.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.2.0",
  git ? { },
}:
let
  versions = {
    "2.1.0" = import ./2.1.0 { inherit lib stdenv ruby; };
    "2.1.1" = import ./2.1.1 { inherit lib stdenv ruby; };
    "2.2.0" = import ./2.2.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "capistrano-bundler: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "capistrano-bundler: unknown version '${version}'")
