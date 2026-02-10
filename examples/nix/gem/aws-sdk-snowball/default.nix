#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-snowball
#
# Versions: 1.96.0, 1.97.0, 1.98.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.98.0",
  git ? { },
}:
let
  versions = {
    "1.96.0" = import ./1.96.0 { inherit lib stdenv ruby; };
    "1.97.0" = import ./1.97.0 { inherit lib stdenv ruby; };
    "1.98.0" = import ./1.98.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-snowball: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-snowball: unknown version '${version}'")
