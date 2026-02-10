#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# bullet
#
# Versions: 7.1.6, 8.0.7, 8.0.8, 8.1.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "8.1.0",
  git ? { },
}:
let
  versions = {
    "7.1.6" = import ./7.1.6 { inherit lib stdenv ruby; };
    "8.0.7" = import ./8.0.7 { inherit lib stdenv ruby; };
    "8.0.8" = import ./8.0.8 { inherit lib stdenv ruby; };
    "8.1.0" = import ./8.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "bullet: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "bullet: unknown version '${version}'")
