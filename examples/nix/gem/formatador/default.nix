#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# formatador
#
# Versions: 1.1.0, 1.2.1, 1.2.2, 1.2.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.3",
  git ? { },
}:
let
  versions = {
    "1.1.0" = import ./1.1.0 { inherit lib stdenv ruby; };
    "1.2.1" = import ./1.2.1 { inherit lib stdenv ruby; };
    "1.2.2" = import ./1.2.2 { inherit lib stdenv ruby; };
    "1.2.3" = import ./1.2.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "formatador: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "formatador: unknown version '${version}'")
