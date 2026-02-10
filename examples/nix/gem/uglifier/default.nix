#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# uglifier
#
# Versions: 4.1.20, 4.2.0, 4.2.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.2.1",
  git ? { },
}:
let
  versions = {
    "4.1.20" = import ./4.1.20 { inherit lib stdenv ruby; };
    "4.2.0" = import ./4.2.0 { inherit lib stdenv ruby; };
    "4.2.1" = import ./4.2.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "uglifier: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "uglifier: unknown version '${version}'")
