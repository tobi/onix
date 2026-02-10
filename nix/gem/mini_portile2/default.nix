#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mini_portile2
#
# Versions: 2.8.7, 2.8.8, 2.8.9
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.8.9",
  git ? { },
}:
let
  versions = {
    "2.8.7" = import ./2.8.7 { inherit lib stdenv ruby; };
    "2.8.8" = import ./2.8.8 { inherit lib stdenv ruby; };
    "2.8.9" = import ./2.8.9 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mini_portile2: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "mini_portile2: unknown version '${version}'")
