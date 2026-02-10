#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-transcribestreamingservice
#
# Versions: 1.95.0, 1.96.0, 1.97.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.97.0",
  git ? { },
}:
let
  versions = {
    "1.95.0" = import ./1.95.0 { inherit lib stdenv ruby; };
    "1.96.0" = import ./1.96.0 { inherit lib stdenv ruby; };
    "1.97.0" = import ./1.97.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-transcribestreamingservice: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-transcribestreamingservice: unknown version '${version}'")
