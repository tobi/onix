#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# bunny
#
# Versions: 2.22.0, 2.23.0, 2.24.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.24.0",
  git ? { },
}:
let
  versions = {
    "2.22.0" = import ./2.22.0 { inherit lib stdenv ruby; };
    "2.23.0" = import ./2.23.0 { inherit lib stdenv ruby; };
    "2.24.0" = import ./2.24.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "bunny: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "bunny: unknown version '${version}'")
