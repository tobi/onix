#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# case_transform
#
# Versions: 0.1, 0.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.2",
  git ? { },
}:
let
  versions = {
    "0.1" = import ./0.1 { inherit lib stdenv ruby; };
    "0.2" = import ./0.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "case_transform: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "case_transform: unknown version '${version}'")
