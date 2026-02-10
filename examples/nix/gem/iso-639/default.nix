#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# iso-639
#
# Versions: 0.3.8
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.3.8",
  git ? { },
}:
let
  versions = {
    "0.3.8" = import ./0.3.8 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "iso-639: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "iso-639: unknown version '${version}'")
