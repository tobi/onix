#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ffi-compiler
#
# Versions: 1.0.1, 1.3.1, 1.3.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.3.2",
  git ? { },
}:
let
  versions = {
    "1.0.1" = import ./1.0.1 { inherit lib stdenv ruby; };
    "1.3.1" = import ./1.3.1 { inherit lib stdenv ruby; };
    "1.3.2" = import ./1.3.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ffi-compiler: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "ffi-compiler: unknown version '${version}'")
