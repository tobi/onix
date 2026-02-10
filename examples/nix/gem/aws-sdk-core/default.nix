#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-core
#
# Versions: 3.227.0, 3.230.0, 3.240.0, 3.241.3, 3.241.4, 3.242.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.242.0",
  git ? { },
}:
let
  versions = {
    "3.227.0" = import ./3.227.0 { inherit lib stdenv ruby; };
    "3.230.0" = import ./3.230.0 { inherit lib stdenv ruby; };
    "3.240.0" = import ./3.240.0 { inherit lib stdenv ruby; };
    "3.241.3" = import ./3.241.3 { inherit lib stdenv ruby; };
    "3.241.4" = import ./3.241.4 { inherit lib stdenv ruby; };
    "3.242.0" = import ./3.242.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-core: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-core: unknown version '${version}'")
