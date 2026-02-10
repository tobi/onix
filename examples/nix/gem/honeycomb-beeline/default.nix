#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# honeycomb-beeline
#
# Versions: 2.11.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.11.0",
  git ? { },
}:
let
  versions = {
    "2.11.0" = import ./2.11.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "honeycomb-beeline: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "honeycomb-beeline: unknown version '${version}'")
