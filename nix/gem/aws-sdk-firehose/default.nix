#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-firehose
#
# Versions: 1.103.0, 1.104.0, 1.105.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.105.0",
  git ? { },
}:
let
  versions = {
    "1.103.0" = import ./1.103.0 { inherit lib stdenv ruby; };
    "1.104.0" = import ./1.104.0 { inherit lib stdenv ruby; };
    "1.105.0" = import ./1.105.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-firehose: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-firehose: unknown version '${version}'")
