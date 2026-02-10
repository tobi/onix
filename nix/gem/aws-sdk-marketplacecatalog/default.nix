#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-marketplacecatalog
#
# Versions: 1.73.0, 1.74.0, 1.75.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.75.0",
  git ? { },
}:
let
  versions = {
    "1.73.0" = import ./1.73.0 { inherit lib stdenv ruby; };
    "1.74.0" = import ./1.74.0 { inherit lib stdenv ruby; };
    "1.75.0" = import ./1.75.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-marketplacecatalog: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-marketplacecatalog: unknown version '${version}'")
