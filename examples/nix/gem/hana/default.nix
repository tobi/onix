#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# hana
#
# Versions: 1.3.5, 1.3.6, 1.3.7
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.3.7",
  git ? { },
}:
let
  versions = {
    "1.3.5" = import ./1.3.5 { inherit lib stdenv ruby; };
    "1.3.6" = import ./1.3.6 { inherit lib stdenv ruby; };
    "1.3.7" = import ./1.3.7 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "hana: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "hana: unknown version '${version}'")
