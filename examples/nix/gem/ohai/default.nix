#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ohai
#
# Versions: 18.2.8, 19.0.3, 19.1.16
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "19.1.16",
  git ? { },
}:
let
  versions = {
    "18.2.8" = import ./18.2.8 { inherit lib stdenv ruby; };
    "19.0.3" = import ./19.0.3 { inherit lib stdenv ruby; };
    "19.1.16" = import ./19.1.16 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ohai: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "ohai: unknown version '${version}'")
