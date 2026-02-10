#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# telephone_number
#
# Versions: 1.4.20
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.4.20",
  git ? { },
}:
let
  versions = {
    "1.4.20" = import ./1.4.20 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "telephone_number: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "telephone_number: unknown version '${version}'")
