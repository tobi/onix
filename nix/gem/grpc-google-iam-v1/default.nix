#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# grpc-google-iam-v1
#
# Versions: 1.9.0, 1.10.0, 1.11.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.11.0",
  git ? { },
}:
let
  versions = {
    "1.9.0" = import ./1.9.0 { inherit lib stdenv ruby; };
    "1.10.0" = import ./1.10.0 { inherit lib stdenv ruby; };
    "1.11.0" = import ./1.11.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "grpc-google-iam-v1: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "grpc-google-iam-v1: unknown version '${version}'")
