#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# administrate
#
# Versions: 0.20.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.20.1",
  git ? { },
}:
let
  versions = {
    "0.20.1" = import ./0.20.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "administrate: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "administrate: unknown version '${version}'")
