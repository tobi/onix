#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rpam2
#
# Versions: 4.0.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.0.2",
  git ? { },
}:
let
  versions = {
    "4.0.2" = import ./4.0.2 { inherit lib stdenv ruby pkgs; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rpam2: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rpam2: unknown version '${version}'")
