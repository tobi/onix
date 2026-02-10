#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# reline
#
# Versions: 0.3.6, 0.5.3, 0.6.1, 0.6.2, 0.6.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.6.3",
  git ? { },
}:
let
  versions = {
    "0.3.6" = import ./0.3.6 { inherit lib stdenv ruby; };
    "0.5.3" = import ./0.5.3 { inherit lib stdenv ruby; };
    "0.6.1" = import ./0.6.1 { inherit lib stdenv ruby; };
    "0.6.2" = import ./0.6.2 { inherit lib stdenv ruby; };
    "0.6.3" = import ./0.6.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "reline: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "reline: unknown version '${version}'")
