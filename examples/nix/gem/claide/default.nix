#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# claide
#
# Versions: 1.0.2, 1.0.3, 1.1.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.1.0",
  git ? { },
}:
let
  versions = {
    "1.0.2" = import ./1.0.2 { inherit lib stdenv ruby; };
    "1.0.3" = import ./1.0.3 { inherit lib stdenv ruby; };
    "1.1.0" = import ./1.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "claide: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "claide: unknown version '${version}'")
