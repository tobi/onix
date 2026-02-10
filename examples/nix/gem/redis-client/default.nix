#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# redis-client
#
# Versions: 0.22.2, 0.25.2, 0.26.1, 0.26.2, 0.26.3, 0.26.4
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.26.4",
  git ? { },
}:
let
  versions = {
    "0.22.2" = import ./0.22.2 { inherit lib stdenv ruby; };
    "0.25.2" = import ./0.25.2 { inherit lib stdenv ruby; };
    "0.26.1" = import ./0.26.1 { inherit lib stdenv ruby; };
    "0.26.2" = import ./0.26.2 { inherit lib stdenv ruby; };
    "0.26.3" = import ./0.26.3 { inherit lib stdenv ruby; };
    "0.26.4" = import ./0.26.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "redis-client: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "redis-client: unknown version '${version}'")
