#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# httparty
#
# Versions: 0.21.0, 0.24.0, 0.24.1, 0.24.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.24.2",
  git ? { },
}:
let
  versions = {
    "0.21.0" = import ./0.21.0 { inherit lib stdenv ruby; };
    "0.24.0" = import ./0.24.0 { inherit lib stdenv ruby; };
    "0.24.1" = import ./0.24.1 { inherit lib stdenv ruby; };
    "0.24.2" = import ./0.24.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "httparty: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "httparty: unknown version '${version}'")
