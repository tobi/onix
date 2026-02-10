#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# llhttp-ffi
#
# Versions: 0.4.0, 0.5.0, 0.5.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.5.1",
  git ? { },
}:
let
  versions = {
    "0.4.0" = import ./0.4.0 { inherit lib stdenv ruby; };
    "0.5.0" = import ./0.5.0 { inherit lib stdenv ruby; };
    "0.5.1" = import ./0.5.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "llhttp-ffi: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "llhttp-ffi: unknown version '${version}'")
