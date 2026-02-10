#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-configservice
#
# Versions: 1.144.0, 1.145.0, 1.146.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.146.0",
  git ? { },
}:
let
  versions = {
    "1.144.0" = import ./1.144.0 { inherit lib stdenv ruby; };
    "1.145.0" = import ./1.145.0 { inherit lib stdenv ruby; };
    "1.146.0" = import ./1.146.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-configservice: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-configservice: unknown version '${version}'")
