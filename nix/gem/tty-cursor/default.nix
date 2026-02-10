#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tty-cursor
#
# Versions: 0.6.1, 0.7.0, 0.7.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.7.1",
  git ? { },
}:
let
  versions = {
    "0.6.1" = import ./0.6.1 { inherit lib stdenv ruby; };
    "0.7.0" = import ./0.7.0 { inherit lib stdenv ruby; };
    "0.7.1" = import ./0.7.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "tty-cursor: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "tty-cursor: unknown version '${version}'")
