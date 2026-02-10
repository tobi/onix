#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pdf-reader
#
# Versions: 2.14.1, 2.15.0, 2.15.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.15.1",
  git ? { },
}:
let
  versions = {
    "2.14.1" = import ./2.14.1 { inherit lib stdenv ruby; };
    "2.15.0" = import ./2.15.0 { inherit lib stdenv ruby; };
    "2.15.1" = import ./2.15.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "pdf-reader: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "pdf-reader: unknown version '${version}'")
