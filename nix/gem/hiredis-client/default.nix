#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# hiredis-client
#
# Versions: 0.26.4
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.26.4",
  git ? { },
}:
let
  versions = {
    "0.26.4" = import ./0.26.4 { inherit lib stdenv ruby pkgs; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "hiredis-client: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "hiredis-client: unknown version '${version}'")
