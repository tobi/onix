#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop-discourse
#
# Versions: 3.13.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.13.3",
  git ? { },
}:
let
  versions = {
    "3.13.3" = import ./3.13.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rubocop-discourse: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rubocop-discourse: unknown version '${version}'")
