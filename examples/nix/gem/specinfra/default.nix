#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# specinfra
#
# Versions: 2.93.0, 2.94.0, 2.94.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.94.1",
  git ? { },
}:
let
  versions = {
    "2.93.0" = import ./2.93.0 { inherit lib stdenv ruby; };
    "2.94.0" = import ./2.94.0 { inherit lib stdenv ruby; };
    "2.94.1" = import ./2.94.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "specinfra: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "specinfra: unknown version '${version}'")
