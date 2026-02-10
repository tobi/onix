#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# gapic-common
#
# Versions: 0.20.0, 1.0.1, 1.1.0, 1.2.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.0",
  git ? { },
}:
let
  versions = {
    "0.20.0" = import ./0.20.0 { inherit lib stdenv ruby; };
    "1.0.1" = import ./1.0.1 { inherit lib stdenv ruby; };
    "1.1.0" = import ./1.1.0 { inherit lib stdenv ruby; };
    "1.2.0" = import ./1.2.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "gapic-common: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "gapic-common: unknown version '${version}'")
