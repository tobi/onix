#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# xcodeproj
#
# Versions: 1.25.1, 1.26.0, 1.27.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.27.0",
  git ? { },
}:
let
  versions = {
    "1.25.1" = import ./1.25.1 { inherit lib stdenv ruby; };
    "1.26.0" = import ./1.26.0 { inherit lib stdenv ruby; };
    "1.27.0" = import ./1.27.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "xcodeproj: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "xcodeproj: unknown version '${version}'")
