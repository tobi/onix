#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faraday-encoding
#
# Versions: 0.0.5
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.0.5",
  git ? { },
}:
let
  versions = {
    "0.0.5" = import ./0.0.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "faraday-encoding: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "faraday-encoding: unknown version '${version}'")
