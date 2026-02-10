#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rack-cache
#
# Versions: 1.15.0, 1.16.0, 1.17.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.17.0",
  git ? { },
}:
let
  versions = {
    "1.15.0" = import ./1.15.0 { inherit lib stdenv ruby; };
    "1.16.0" = import ./1.16.0 { inherit lib stdenv ruby; };
    "1.17.0" = import ./1.17.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rack-cache: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rack-cache: unknown version '${version}'")
