#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-directoryservice
#
# Versions: 1.98.0, 1.99.0, 1.100.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.100.0",
  git ? { },
}:
let
  versions = {
    "1.98.0" = import ./1.98.0 { inherit lib stdenv ruby; };
    "1.99.0" = import ./1.99.0 { inherit lib stdenv ruby; };
    "1.100.0" = import ./1.100.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-directoryservice: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-directoryservice: unknown version '${version}'")
