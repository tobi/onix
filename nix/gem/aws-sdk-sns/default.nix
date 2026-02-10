#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-sns
#
# Versions: 1.70.0, 1.92.0, 1.96.0, 1.110.0, 1.111.0, 1.112.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.112.0",
  git ? { },
}:
let
  versions = {
    "1.70.0" = import ./1.70.0 { inherit lib stdenv ruby; };
    "1.92.0" = import ./1.92.0 { inherit lib stdenv ruby; };
    "1.96.0" = import ./1.96.0 { inherit lib stdenv ruby; };
    "1.110.0" = import ./1.110.0 { inherit lib stdenv ruby; };
    "1.111.0" = import ./1.111.0 { inherit lib stdenv ruby; };
    "1.112.0" = import ./1.112.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-sns: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-sns: unknown version '${version}'")
