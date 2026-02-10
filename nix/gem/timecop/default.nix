#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# timecop
#
# Versions: 0.9.8, 0.9.9, 0.9.10
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.9.10",
  git ? { },
}:
let
  versions = {
    "0.9.8" = import ./0.9.8 { inherit lib stdenv ruby; };
    "0.9.9" = import ./0.9.9 { inherit lib stdenv ruby; };
    "0.9.10" = import ./0.9.10 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "timecop: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "timecop: unknown version '${version}'")
