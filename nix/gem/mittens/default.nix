#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mittens
#
# Versions: 0.3.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.3.1",
  git ? { },
}:
let
  versions = {
    "0.3.1" = import ./0.3.1 { inherit lib stdenv ruby pkgs; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mittens: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "mittens: unknown version '${version}'")
