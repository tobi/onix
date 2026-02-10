#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faraday-http-cache
#
# Versions: 2.5.0, 2.5.1, 2.6.0, 2.6.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.6.1",
  git ? { },
}:
let
  versions = {
    "2.5.0" = import ./2.5.0 { inherit lib stdenv ruby; };
    "2.5.1" = import ./2.5.1 { inherit lib stdenv ruby; };
    "2.6.0" = import ./2.6.0 { inherit lib stdenv ruby; };
    "2.6.1" = import ./2.6.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "faraday-http-cache: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "faraday-http-cache: unknown version '${version}'")
