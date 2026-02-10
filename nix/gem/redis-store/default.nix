#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# redis-store
#
# Versions: 1.9.2, 1.10.0, 1.11.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.11.0",
  git ? { },
}:
let
  versions = {
    "1.9.2" = import ./1.9.2 { inherit lib stdenv ruby; };
    "1.10.0" = import ./1.10.0 { inherit lib stdenv ruby; };
    "1.11.0" = import ./1.11.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "redis-store: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "redis-store: unknown version '${version}'")
