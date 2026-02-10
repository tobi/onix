#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-secretsmanager
#
# Versions: 1.126.0, 1.127.0, 1.128.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.128.0",
  git ? { },
}:
let
  versions = {
    "1.126.0" = import ./1.126.0 { inherit lib stdenv ruby; };
    "1.127.0" = import ./1.127.0 { inherit lib stdenv ruby; };
    "1.128.0" = import ./1.128.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-secretsmanager: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-secretsmanager: unknown version '${version}'")
