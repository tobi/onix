#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# redis-rack
#
# Versions: 2.1.3, 2.1.4, 3.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.0.0",
  git ? { },
}:
let
  versions = {
    "2.1.3" = import ./2.1.3 { inherit lib stdenv ruby; };
    "2.1.4" = import ./2.1.4 { inherit lib stdenv ruby; };
    "3.0.0" = import ./3.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "redis-rack: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "redis-rack: unknown version '${version}'")
