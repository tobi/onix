#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-schemas
#
# Versions: 1.63.0, 1.64.0, 1.65.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.65.0",
  git ? { },
}:
let
  versions = {
    "1.63.0" = import ./1.63.0 { inherit lib stdenv ruby; };
    "1.64.0" = import ./1.64.0 { inherit lib stdenv ruby; };
    "1.65.0" = import ./1.65.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-schemas: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-schemas: unknown version '${version}'")
