#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# stringex
#
# Versions: 2.8.6
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.8.6",
  git ? { },
}:
let
  versions = {
    "2.8.6" = import ./2.8.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "stringex: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "stringex: unknown version '${version}'")
