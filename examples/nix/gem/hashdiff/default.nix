#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# hashdiff
#
# Versions: 1.1.0, 1.1.2, 1.2.0, 1.2.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.1",
  git ? { },
}:
let
  versions = {
    "1.1.0" = import ./1.1.0 { inherit lib stdenv ruby; };
    "1.1.2" = import ./1.1.2 { inherit lib stdenv ruby; };
    "1.2.0" = import ./1.2.0 { inherit lib stdenv ruby; };
    "1.2.1" = import ./1.2.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "hashdiff: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "hashdiff: unknown version '${version}'")
