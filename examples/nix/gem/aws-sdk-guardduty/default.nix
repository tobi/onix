#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-guardduty
#
# Versions: 1.141.0, 1.142.0, 1.143.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.143.0",
  git ? { },
}:
let
  versions = {
    "1.141.0" = import ./1.141.0 { inherit lib stdenv ruby; };
    "1.142.0" = import ./1.142.0 { inherit lib stdenv ruby; };
    "1.143.0" = import ./1.143.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-guardduty: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-guardduty: unknown version '${version}'")
