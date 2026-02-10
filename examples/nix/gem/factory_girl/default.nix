#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# factory_girl
#
# Versions: 4.8.0, 4.8.1, 4.9.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.9.0",
  git ? { },
}:
let
  versions = {
    "4.8.0" = import ./4.8.0 { inherit lib stdenv ruby; };
    "4.8.1" = import ./4.8.1 { inherit lib stdenv ruby; };
    "4.9.0" = import ./4.9.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "factory_girl: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "factory_girl: unknown version '${version}'")
