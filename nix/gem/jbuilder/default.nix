#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# jbuilder
#
# Versions: 2.11.5, 2.13.0, 2.14.0, 2.14.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.14.1",
  git ? { },
}:
let
  versions = {
    "2.11.5" = import ./2.11.5 { inherit lib stdenv ruby; };
    "2.13.0" = import ./2.13.0 { inherit lib stdenv ruby; };
    "2.14.0" = import ./2.14.0 { inherit lib stdenv ruby; };
    "2.14.1" = import ./2.14.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "jbuilder: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "jbuilder: unknown version '${version}'")
