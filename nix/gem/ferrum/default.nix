#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ferrum
#
# Versions: 0.14
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.14",
  git ? { },
}:
let
  versions = {
    "0.14" = import ./0.14 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ferrum: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "ferrum: unknown version '${version}'")
