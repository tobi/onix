#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# doorkeeper
#
# Versions: 5.8.0, 5.8.1, 5.8.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.8.2",
  git ? { },
}:
let
  versions = {
    "5.8.0" = import ./5.8.0 { inherit lib stdenv ruby; };
    "5.8.1" = import ./5.8.1 { inherit lib stdenv ruby; };
    "5.8.2" = import ./5.8.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "doorkeeper: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "doorkeeper: unknown version '${version}'")
