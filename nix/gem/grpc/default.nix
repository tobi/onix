#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# grpc
#
# Versions: 1.72.0, 1.75.0, 1.76.0, 1.78.0
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
    "1.72.0" = import ./1.72.0 { inherit lib stdenv ruby; };
    "1.75.0" = import ./1.75.0 { inherit lib stdenv ruby; };
    "1.76.0" = import ./1.76.0 { inherit lib stdenv ruby; };
    "1.78.0" = import ./1.78.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "grpc: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "grpc: unknown version '${version}'")
