#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# wmi-lite
#
# Versions: 1.0.2, 1.0.5, 1.0.7
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.7",
  git ? { },
}:
let
  versions = {
    "1.0.2" = import ./1.0.2 { inherit lib stdenv ruby; };
    "1.0.5" = import ./1.0.5 { inherit lib stdenv ruby; };
    "1.0.7" = import ./1.0.7 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "wmi-lite: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "wmi-lite: unknown version '${version}'")
