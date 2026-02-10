#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# octokit
#
# Versions: 5.6.1, 7.2.0, 9.1.0, 9.2.0, 10.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "10.0.0",
  git ? { },
}:
let
  versions = {
    "5.6.1" = import ./5.6.1 { inherit lib stdenv ruby; };
    "7.2.0" = import ./7.2.0 { inherit lib stdenv ruby; };
    "9.1.0" = import ./9.1.0 { inherit lib stdenv ruby; };
    "9.2.0" = import ./9.2.0 { inherit lib stdenv ruby; };
    "10.0.0" = import ./10.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "octokit: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "octokit: unknown version '${version}'")
