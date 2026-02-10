#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# elasticsearch-model
#
# Versions: 7.2.1, 8.0.0, 8.0.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "8.0.1",
  git ? { },
}:
let
  versions = {
    "7.2.1" = import ./7.2.1 { inherit lib stdenv ruby; };
    "8.0.0" = import ./8.0.0 { inherit lib stdenv ruby; };
    "8.0.1" = import ./8.0.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "elasticsearch-model: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "elasticsearch-model: unknown version '${version}'")
