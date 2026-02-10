#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# os
#
# Versions: 1.1.1, 1.1.2, 1.1.4
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.1.4",
  git ? { },
}:
let
  versions = {
    "1.1.1" = import ./1.1.1 { inherit lib stdenv ruby; };
    "1.1.2" = import ./1.1.2 { inherit lib stdenv ruby; };
    "1.1.4" = import ./1.1.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "os: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "os: unknown version '${version}'")
