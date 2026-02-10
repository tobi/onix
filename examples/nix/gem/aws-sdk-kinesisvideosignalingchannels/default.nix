#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-kinesisvideosignalingchannels
#
# Versions: 1.60.0, 1.61.0, 1.62.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.62.0",
  git ? { },
}:
let
  versions = {
    "1.60.0" = import ./1.60.0 { inherit lib stdenv ruby; };
    "1.61.0" = import ./1.61.0 { inherit lib stdenv ruby; };
    "1.62.0" = import ./1.62.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-kinesisvideosignalingchannels: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-kinesisvideosignalingchannels: unknown version '${version}'")
