#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tins
#
# Versions: 1.50.0, 1.51.0, 1.51.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.51.1",
  git ? { },
}:
let
  versions = {
    "1.50.0" = import ./1.50.0 { inherit lib stdenv ruby; };
    "1.51.0" = import ./1.51.0 { inherit lib stdenv ruby; };
    "1.51.1" = import ./1.51.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "tins: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "tins: unknown version '${version}'")
