#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# gserver
#
# Versions: 0.0.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.0.1",
  git ? { },
}:
let
  versions = {
    "0.0.1" = import ./0.0.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "gserver: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "gserver: unknown version '${version}'")
