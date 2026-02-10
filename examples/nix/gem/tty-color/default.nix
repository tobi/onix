#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tty-color
#
# Versions: 0.5.1, 0.5.2, 0.6.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.6.0",
  git ? { },
}:
let
  versions = {
    "0.5.1" = import ./0.5.1 { inherit lib stdenv ruby; };
    "0.5.2" = import ./0.5.2 { inherit lib stdenv ruby; };
    "0.6.0" = import ./0.6.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "tty-color: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "tty-color: unknown version '${version}'")
