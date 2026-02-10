#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-health
#
# Versions: 1.93.0, 1.94.0, 1.95.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.95.0",
  git ? { },
}:
let
  versions = {
    "1.93.0" = import ./1.93.0 { inherit lib stdenv ruby; };
    "1.94.0" = import ./1.94.0 { inherit lib stdenv ruby; };
    "1.95.0" = import ./1.95.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-health: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-health: unknown version '${version}'")
