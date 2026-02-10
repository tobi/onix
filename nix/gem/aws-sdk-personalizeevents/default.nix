#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-personalizeevents
#
# Versions: 1.71.0, 1.72.0, 1.73.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.73.0",
  git ? { },
}:
let
  versions = {
    "1.71.0" = import ./1.71.0 { inherit lib stdenv ruby; };
    "1.72.0" = import ./1.72.0 { inherit lib stdenv ruby; };
    "1.73.0" = import ./1.73.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-personalizeevents: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-personalizeevents: unknown version '${version}'")
