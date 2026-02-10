#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# websocket
#
# Versions: 1.2.9, 1.2.10, 1.2.11
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.11",
  git ? { },
}:
let
  versions = {
    "1.2.9" = import ./1.2.9 { inherit lib stdenv ruby; };
    "1.2.10" = import ./1.2.10 { inherit lib stdenv ruby; };
    "1.2.11" = import ./1.2.11 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "websocket: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "websocket: unknown version '${version}'")
