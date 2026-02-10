#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-lambdapreview
#
# Versions: 1.48.0, 1.49.0, 1.50.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.50.0",
  git ? { },
}:
let
  versions = {
    "1.48.0" = import ./1.48.0 { inherit lib stdenv ruby; };
    "1.49.0" = import ./1.49.0 { inherit lib stdenv ruby; };
    "1.50.0" = import ./1.50.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-lambdapreview: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-lambdapreview: unknown version '${version}'")
