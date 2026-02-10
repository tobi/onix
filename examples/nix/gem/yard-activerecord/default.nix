#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# yard-activerecord
#
# Versions: 0.0.16
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.0.16",
  git ? { },
}:
let
  versions = {
    "0.0.16" = import ./0.0.16 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "yard-activerecord: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "yard-activerecord: unknown version '${version}'")
