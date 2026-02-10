#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ancestry
#
# Versions: 4.3.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.3.3",
  git ? { },
}:
let
  versions = {
    "4.3.3" = import ./4.3.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ancestry: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "ancestry: unknown version '${version}'")
