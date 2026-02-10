#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ox
#
# Versions: 2.14.23
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.14.23",
  git ? { },
}:
let
  versions = {
    "2.14.23" = import ./2.14.23 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ox: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "ox: unknown version '${version}'")
