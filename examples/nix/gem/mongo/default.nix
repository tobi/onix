#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mongo
#
# Versions: 2.21.3, 2.22.0, 2.23.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.23.0",
  git ? { },
}:
let
  versions = {
    "2.21.3" = import ./2.21.3 { inherit lib stdenv ruby; };
    "2.22.0" = import ./2.22.0 { inherit lib stdenv ruby; };
    "2.23.0" = import ./2.23.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mongo: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "mongo: unknown version '${version}'")
