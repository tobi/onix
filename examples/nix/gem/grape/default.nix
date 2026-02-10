#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# grape
#
# Versions: 3.0.1, 3.1.0, 3.1.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.1.1",
  git ? { },
}:
let
  versions = {
    "3.0.1" = import ./3.0.1 { inherit lib stdenv ruby; };
    "3.1.0" = import ./3.1.0 { inherit lib stdenv ruby; };
    "3.1.1" = import ./3.1.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "grape: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "grape: unknown version '${version}'")
