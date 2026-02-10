#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sassc-embedded
#
# Versions: 1.80.5
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.80.5",
  git ? { },
}:
let
  versions = {
    "1.80.5" = import ./1.80.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sassc-embedded: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "sassc-embedded: unknown version '${version}'")
