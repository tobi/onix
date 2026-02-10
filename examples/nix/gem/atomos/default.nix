#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# atomos
#
# Versions: 0.1.2, 0.1.3, 1.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.0",
  git ? { },
}:
let
  versions = {
    "0.1.2" = import ./0.1.2 { inherit lib stdenv ruby; };
    "0.1.3" = import ./0.1.3 { inherit lib stdenv ruby; };
    "1.0.0" = import ./1.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "atomos: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "atomos: unknown version '${version}'")
