#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-apigateway
#
# Versions: 1.129.0, 1.130.0, 1.131.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.131.0",
  git ? { },
}:
let
  versions = {
    "1.129.0" = import ./1.129.0 { inherit lib stdenv ruby; };
    "1.130.0" = import ./1.130.0 { inherit lib stdenv ruby; };
    "1.131.0" = import ./1.131.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-apigateway: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-apigateway: unknown version '${version}'")
