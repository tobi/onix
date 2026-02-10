#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-medialive
#
# Versions: 1.176.0, 1.177.0, 1.178.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.178.0",
  git ? { },
}:
let
  versions = {
    "1.176.0" = import ./1.176.0 { inherit lib stdenv ruby; };
    "1.177.0" = import ./1.177.0 { inherit lib stdenv ruby; };
    "1.178.0" = import ./1.178.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-medialive: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-medialive: unknown version '${version}'")
