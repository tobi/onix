#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# simplecov
#
# Versions: 0.21.1, 0.21.2, 0.22.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.22.0",
  git ? { },
}:
let
  versions = {
    "0.21.1" = import ./0.21.1 { inherit lib stdenv ruby; };
    "0.21.2" = import ./0.21.2 { inherit lib stdenv ruby; };
    "0.22.0" = import ./0.22.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "simplecov: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "simplecov: unknown version '${version}'")
