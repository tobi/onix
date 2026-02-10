#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-comprehend
#
# Versions: 1.110.0, 1.111.0, 1.112.0
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
    "1.110.0" = import ./1.110.0 { inherit lib stdenv ruby; };
    "1.111.0" = import ./1.111.0 { inherit lib stdenv ruby; };
    "1.112.0" = import ./1.112.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-comprehend: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-comprehend: unknown version '${version}'")
