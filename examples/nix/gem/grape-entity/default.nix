#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# grape-entity
#
# Versions: 0.10.2, 1.0.0, 1.0.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.1",
  git ? { },
}:
let
  versions = {
    "0.10.2" = import ./0.10.2 { inherit lib stdenv ruby; };
    "1.0.0" = import ./1.0.0 { inherit lib stdenv ruby; };
    "1.0.1" = import ./1.0.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "grape-entity: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "grape-entity: unknown version '${version}'")
