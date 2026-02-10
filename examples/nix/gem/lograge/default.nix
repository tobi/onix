#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# lograge
#
# Versions: 0.12.0, 0.13.0, 0.14.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.14.0",
  git ? { },
}:
let
  versions = {
    "0.12.0" = import ./0.12.0 { inherit lib stdenv ruby; };
    "0.13.0" = import ./0.13.0 { inherit lib stdenv ruby; };
    "0.14.0" = import ./0.14.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "lograge: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "lograge: unknown version '${version}'")
