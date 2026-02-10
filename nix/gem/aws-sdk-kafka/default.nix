#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-kafka
#
# Versions: 1.102.0, 1.103.0, 1.104.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.104.0",
  git ? { },
}:
let
  versions = {
    "1.102.0" = import ./1.102.0 { inherit lib stdenv ruby; };
    "1.103.0" = import ./1.103.0 { inherit lib stdenv ruby; };
    "1.104.0" = import ./1.104.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-kafka: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-kafka: unknown version '${version}'")
