#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# annotaterb
#
# Versions: 4.20.0, 4.21.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.21.0",
  git ? { },
}:
let
  versions = {
    "4.20.0" = import ./4.20.0 { inherit lib stdenv ruby; };
    "4.21.0" = import ./4.21.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "annotaterb: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "annotaterb: unknown version '${version}'")
