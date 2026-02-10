#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-ec2
#
# Versions: 1.595.0, 1.596.0, 1.597.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.597.0",
  git ? { },
}:
let
  versions = {
    "1.595.0" = import ./1.595.0 { inherit lib stdenv ruby; };
    "1.596.0" = import ./1.596.0 { inherit lib stdenv ruby; };
    "1.597.0" = import ./1.597.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-ec2: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-ec2: unknown version '${version}'")
