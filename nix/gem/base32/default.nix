#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# base32
#
# Versions: 0.3.1, 0.3.2, 0.3.4
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.3.4",
  git ? { },
}:
let
  versions = {
    "0.3.1" = import ./0.3.1 { inherit lib stdenv ruby; };
    "0.3.2" = import ./0.3.2 { inherit lib stdenv ruby; };
    "0.3.4" = import ./0.3.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "base32: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "base32: unknown version '${version}'")
