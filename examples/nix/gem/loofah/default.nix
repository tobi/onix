#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# loofah
#
# Versions: 2.23.1, 2.24.0, 2.24.1, 2.25.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.25.0",
  git ? { },
}:
let
  versions = {
    "2.23.1" = import ./2.23.1 { inherit lib stdenv ruby; };
    "2.24.0" = import ./2.24.0 { inherit lib stdenv ruby; };
    "2.24.1" = import ./2.24.1 { inherit lib stdenv ruby; };
    "2.25.0" = import ./2.25.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "loofah: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "loofah: unknown version '${version}'")
