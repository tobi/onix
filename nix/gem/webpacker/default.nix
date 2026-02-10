#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# webpacker
#
# Versions: 5.4.2, 5.4.3, 5.4.4
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.4.4",
  git ? { },
}:
let
  versions = {
    "5.4.2" = import ./5.4.2 { inherit lib stdenv ruby; };
    "5.4.3" = import ./5.4.3 { inherit lib stdenv ruby; };
    "5.4.4" = import ./5.4.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "webpacker: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "webpacker: unknown version '${version}'")
