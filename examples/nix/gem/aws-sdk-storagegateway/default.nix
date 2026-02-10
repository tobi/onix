#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-storagegateway
#
# Versions: 1.121.0, 1.122.0, 1.123.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.123.0",
  git ? { },
}:
let
  versions = {
    "1.121.0" = import ./1.121.0 { inherit lib stdenv ruby; };
    "1.122.0" = import ./1.122.0 { inherit lib stdenv ruby; };
    "1.123.0" = import ./1.123.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-storagegateway: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-storagegateway: unknown version '${version}'")
