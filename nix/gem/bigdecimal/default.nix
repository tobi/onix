#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# bigdecimal
#
# Versions: 3.1.7, 3.2.2, 3.2.3, 3.3.1, 4.0.0, 4.0.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.0.1",
  git ? { },
}:
let
  versions = {
    "3.1.7" = import ./3.1.7 { inherit lib stdenv ruby; };
    "3.2.2" = import ./3.2.2 { inherit lib stdenv ruby; };
    "3.2.3" = import ./3.2.3 { inherit lib stdenv ruby; };
    "3.3.1" = import ./3.3.1 { inherit lib stdenv ruby; };
    "4.0.0" = import ./4.0.0 { inherit lib stdenv ruby; };
    "4.0.1" = import ./4.0.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "bigdecimal: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "bigdecimal: unknown version '${version}'")
