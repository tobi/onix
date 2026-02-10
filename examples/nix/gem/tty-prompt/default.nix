#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tty-prompt
#
# Versions: 0.22.0, 0.23.0, 0.23.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.23.1",
  git ? { },
}:
let
  versions = {
    "0.22.0" = import ./0.22.0 { inherit lib stdenv ruby; };
    "0.23.0" = import ./0.23.0 { inherit lib stdenv ruby; };
    "0.23.1" = import ./0.23.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "tty-prompt: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "tty-prompt: unknown version '${version}'")
