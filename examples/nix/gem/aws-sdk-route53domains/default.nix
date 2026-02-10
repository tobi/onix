#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-route53domains
#
# Versions: 1.89.0, 1.90.0, 1.91.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.91.0",
  git ? { },
}:
let
  versions = {
    "1.89.0" = import ./1.89.0 { inherit lib stdenv ruby; };
    "1.90.0" = import ./1.90.0 { inherit lib stdenv ruby; };
    "1.91.0" = import ./1.91.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-route53domains: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-route53domains: unknown version '${version}'")
