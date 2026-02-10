#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-redshift
#
# Versions: 1.154.0, 1.155.0, 1.156.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.156.0",
  git ? { },
}:
let
  versions = {
    "1.154.0" = import ./1.154.0 { inherit lib stdenv ruby; };
    "1.155.0" = import ./1.155.0 { inherit lib stdenv ruby; };
    "1.156.0" = import ./1.156.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-redshift: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-redshift: unknown version '${version}'")
