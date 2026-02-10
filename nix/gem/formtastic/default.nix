#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# formtastic
#
# Versions: 3.1.6, 4.0.0, 5.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.0.0",
  git ? { },
}:
let
  versions = {
    "3.1.6" = import ./3.1.6 { inherit lib stdenv ruby; };
    "4.0.0" = import ./4.0.0 { inherit lib stdenv ruby; };
    "5.0.0" = import ./5.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "formtastic: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "formtastic: unknown version '${version}'")
