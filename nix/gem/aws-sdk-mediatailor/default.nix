#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-mediatailor
#
# Versions: 1.112.0, 1.113.0, 1.114.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.114.0",
  git ? { },
}:
let
  versions = {
    "1.112.0" = import ./1.112.0 { inherit lib stdenv ruby; };
    "1.113.0" = import ./1.113.0 { inherit lib stdenv ruby; };
    "1.114.0" = import ./1.114.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-mediatailor: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-mediatailor: unknown version '${version}'")
