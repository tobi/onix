#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cppjieba_rb
#
# Versions: 0.4.4
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.4.4",
  git ? { },
}:
let
  versions = {
    "0.4.4" = import ./0.4.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "cppjieba_rb: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "cppjieba_rb: unknown version '${version}'")
