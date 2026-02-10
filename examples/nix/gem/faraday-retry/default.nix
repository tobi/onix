#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faraday-retry
#
# Versions: 2.1.0, 2.2.1, 2.3.1, 2.3.2, 2.4.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.4.0",
  git ? { },
}:
let
  versions = {
    "2.1.0" = import ./2.1.0 { inherit lib stdenv ruby; };
    "2.2.1" = import ./2.2.1 { inherit lib stdenv ruby; };
    "2.3.1" = import ./2.3.1 { inherit lib stdenv ruby; };
    "2.3.2" = import ./2.3.2 { inherit lib stdenv ruby; };
    "2.4.0" = import ./2.4.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "faraday-retry: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "faraday-retry: unknown version '${version}'")
