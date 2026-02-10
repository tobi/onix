#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# activerecord-import
#
# Versions: 2.0.0, 2.1.0, 2.2.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.2.0",
  git ? { },
}:
let
  versions = {
    "2.0.0" = import ./2.0.0 { inherit lib stdenv ruby; };
    "2.1.0" = import ./2.1.0 { inherit lib stdenv ruby; };
    "2.2.0" = import ./2.2.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "activerecord-import: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "activerecord-import: unknown version '${version}'")
