#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# dry-struct
#
# Versions: 1.7.0, 1.7.1, 1.8.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.8.0",
  git ? { },
}:
let
  versions = {
    "1.7.0" = import ./1.7.0 { inherit lib stdenv ruby; };
    "1.7.1" = import ./1.7.1 { inherit lib stdenv ruby; };
    "1.8.0" = import ./1.8.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "dry-struct: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "dry-struct: unknown version '${version}'")
