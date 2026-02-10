#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# erubis
#
# Versions: 2.6.5, 2.7.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.7.0",
  git ? { },
}:
let
  versions = {
    "2.6.5" = import ./2.6.5 { inherit lib stdenv ruby; };
    "2.7.0" = import ./2.7.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "erubis: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "erubis: unknown version '${version}'")
