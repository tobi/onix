#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-lexmodelbuildingservice
#
# Versions: 1.99.0, 1.100.0, 1.101.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.101.0",
  git ? { },
}:
let
  versions = {
    "1.99.0" = import ./1.99.0 { inherit lib stdenv ruby; };
    "1.100.0" = import ./1.100.0 { inherit lib stdenv ruby; };
    "1.101.0" = import ./1.101.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-lexmodelbuildingservice: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-lexmodelbuildingservice: unknown version '${version}'")
