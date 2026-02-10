#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-pinpointemail
#
# Versions: 1.76.0, 1.77.0, 1.78.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.78.0",
  git ? { },
}:
let
  versions = {
    "1.76.0" = import ./1.76.0 { inherit lib stdenv ruby; };
    "1.77.0" = import ./1.77.0 { inherit lib stdenv ruby; };
    "1.78.0" = import ./1.78.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-pinpointemail: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-pinpointemail: unknown version '${version}'")
