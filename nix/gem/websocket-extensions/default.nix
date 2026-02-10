#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# websocket-extensions
#
# Versions: 0.1.3, 0.1.4, 0.1.5
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.1.5",
  git ? { },
}:
let
  versions = {
    "0.1.3" = import ./0.1.3 { inherit lib stdenv ruby; };
    "0.1.4" = import ./0.1.4 { inherit lib stdenv ruby; };
    "0.1.5" = import ./0.1.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "websocket-extensions: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "websocket-extensions: unknown version '${version}'")
