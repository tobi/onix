#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# memoizable
#
# Versions: 0.4.0, 0.4.1, 0.4.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.4.2",
  git ? { },
}:
let
  versions = {
    "0.4.0" = import ./0.4.0 { inherit lib stdenv ruby; };
    "0.4.1" = import ./0.4.1 { inherit lib stdenv ruby; };
    "0.4.2" = import ./0.4.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "memoizable: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "memoizable: unknown version '${version}'")
