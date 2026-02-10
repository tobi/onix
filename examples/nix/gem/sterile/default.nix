#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sterile
#
# Versions: 1.0.26
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.26",
  git ? { },
}:
let
  versions = {
    "1.0.26" = import ./1.0.26 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sterile: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "sterile: unknown version '${version}'")
