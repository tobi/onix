#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# eye
#
# Versions: 0.9.3, 0.9.4, 0.10.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.10.0",
  git ? { },
}:
let
  versions = {
    "0.9.3" = import ./0.9.3 { inherit lib stdenv ruby; };
    "0.9.4" = import ./0.9.4 { inherit lib stdenv ruby; };
    "0.10.0" = import ./0.10.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "eye: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "eye: unknown version '${version}'")
