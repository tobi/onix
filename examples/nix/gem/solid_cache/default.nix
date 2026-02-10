#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# solid_cache
#
# Versions: 1.0.6, 1.0.10
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.10",
  git ? { },
}:
let
  versions = {
    "1.0.6" = import ./1.0.6 { inherit lib stdenv ruby; };
    "1.0.10" = import ./1.0.10 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "solid_cache: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "solid_cache: unknown version '${version}'")
