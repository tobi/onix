#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk
#
# Versions: 3.1.0, 3.2.0, 3.3.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.3.0",
  git ? { },
}:
let
  versions = {
    "3.1.0" = import ./3.1.0 { inherit lib stdenv ruby; };
    "3.2.0" = import ./3.2.0 { inherit lib stdenv ruby; };
    "3.3.0" = import ./3.3.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk: unknown version '${version}'")
