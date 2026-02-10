#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sshkit
#
# Versions: 1.23.2, 1.24.0, 1.25.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.25.0",
  git ? { },
}:
let
  versions = {
    "1.23.2" = import ./1.23.2 { inherit lib stdenv ruby; };
    "1.24.0" = import ./1.24.0 { inherit lib stdenv ruby; };
    "1.25.0" = import ./1.25.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sshkit: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "sshkit: unknown version '${version}'")
