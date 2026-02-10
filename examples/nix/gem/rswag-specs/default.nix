#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rswag-specs
#
# Versions: 2.5.1, 2.17.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.17.0",
  git ? { },
}:
let
  versions = {
    "2.5.1" = import ./2.5.1 { inherit lib stdenv ruby; };
    "2.17.0" = import ./2.17.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rswag-specs: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rswag-specs: unknown version '${version}'")
