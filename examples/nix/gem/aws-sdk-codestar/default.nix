#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-codestar
#
# Versions: 1.57.0, 1.58.0, 1.59.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.59.0",
  git ? { },
}:
let
  versions = {
    "1.57.0" = import ./1.57.0 { inherit lib stdenv ruby; };
    "1.58.0" = import ./1.58.0 { inherit lib stdenv ruby; };
    "1.59.0" = import ./1.59.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-codestar: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-codestar: unknown version '${version}'")
