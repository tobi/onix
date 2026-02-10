#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-elasticloadbalancingv2
#
# Versions: 1.146.0, 1.147.0, 1.148.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.148.0",
  git ? { },
}:
let
  versions = {
    "1.146.0" = import ./1.146.0 { inherit lib stdenv ruby; };
    "1.147.0" = import ./1.147.0 { inherit lib stdenv ruby; };
    "1.148.0" = import ./1.148.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-elasticloadbalancingv2: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-elasticloadbalancingv2: unknown version '${version}'")
