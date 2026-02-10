#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-resources
#
# Versions: 3.249.0, 3.250.0, 3.251.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.251.0",
  git ? { },
}:
let
  versions = {
    "3.249.0" = import ./3.249.0 { inherit lib stdenv ruby; };
    "3.250.0" = import ./3.250.0 { inherit lib stdenv ruby; };
    "3.251.0" = import ./3.251.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-resources: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-resources: unknown version '${version}'")
