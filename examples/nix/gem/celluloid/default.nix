#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# celluloid
#
# Versions: 0.17.3, 0.17.4, 0.18.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.18.0",
  git ? { },
}:
let
  versions = {
    "0.17.3" = import ./0.17.3 { inherit lib stdenv ruby; };
    "0.17.4" = import ./0.17.4 { inherit lib stdenv ruby; };
    "0.18.0" = import ./0.18.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "celluloid: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "celluloid: unknown version '${version}'")
