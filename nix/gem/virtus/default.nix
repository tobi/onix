#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# virtus
#
# Versions: 1.0.4, 1.0.5, 2.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.0.0",
  git ? { },
}:
let
  versions = {
    "1.0.4" = import ./1.0.4 { inherit lib stdenv ruby; };
    "1.0.5" = import ./1.0.5 { inherit lib stdenv ruby; };
    "2.0.0" = import ./2.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "virtus: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "virtus: unknown version '${version}'")
