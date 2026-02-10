#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fcm
#
# Versions: 1.0.8
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.8",
  git ? { },
}:
let
  versions = {
    "1.0.8" = import ./1.0.8 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "fcm: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "fcm: unknown version '${version}'")
