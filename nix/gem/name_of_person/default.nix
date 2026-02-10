#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# name_of_person
#
# Versions: 1.1.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.1.3",
  git ? { },
}:
let
  versions = {
    "1.1.3" = import ./1.1.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "name_of_person: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "name_of_person: unknown version '${version}'")
