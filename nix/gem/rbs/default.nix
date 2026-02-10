#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rbs
#
# Versions: 2.8.4, 3.9.5, 4.0.0.dev.5
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.0.0.dev.5",
  git ? { },
}:
let
  versions = {
    "2.8.4" = import ./2.8.4 { inherit lib stdenv ruby; };
    "3.9.5" = import ./3.9.5 { inherit lib stdenv ruby; };
    "4.0.0.dev.5" = import ./4.0.0.dev.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rbs: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rbs: unknown version '${version}'")
