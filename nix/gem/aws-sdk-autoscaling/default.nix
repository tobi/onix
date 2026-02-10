#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-autoscaling
#
# Versions: 1.152.0, 1.153.0, 1.154.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.154.0",
  git ? { },
}:
let
  versions = {
    "1.152.0" = import ./1.152.0 { inherit lib stdenv ruby; };
    "1.153.0" = import ./1.153.0 { inherit lib stdenv ruby; };
    "1.154.0" = import ./1.154.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-autoscaling: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-autoscaling: unknown version '${version}'")
