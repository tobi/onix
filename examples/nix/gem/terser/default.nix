#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# terser
#
# Versions: 1.2.2, 1.2.4, 1.2.5, 1.2.6
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.6",
  git ? { },
}:
let
  versions = {
    "1.2.2" = import ./1.2.2 { inherit lib stdenv ruby; };
    "1.2.4" = import ./1.2.4 { inherit lib stdenv ruby; };
    "1.2.5" = import ./1.2.5 { inherit lib stdenv ruby; };
    "1.2.6" = import ./1.2.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "terser: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "terser: unknown version '${version}'")
