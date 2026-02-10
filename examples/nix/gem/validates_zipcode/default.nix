#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# validates_zipcode
#
# Versions: 0.5.4
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.5.4",
  git ? { },
}:
let
  versions = {
    "0.5.4" = import ./0.5.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "validates_zipcode: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "validates_zipcode: unknown version '${version}'")
