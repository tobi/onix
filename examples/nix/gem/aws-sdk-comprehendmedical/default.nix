#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-comprehendmedical
#
# Versions: 1.78.0, 1.79.0, 1.80.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.80.0",
  git ? { },
}:
let
  versions = {
    "1.78.0" = import ./1.78.0 { inherit lib stdenv ruby; };
    "1.79.0" = import ./1.79.0 { inherit lib stdenv ruby; };
    "1.80.0" = import ./1.80.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-comprehendmedical: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-comprehendmedical: unknown version '${version}'")
