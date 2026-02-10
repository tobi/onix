#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# chewy
#
# Versions: 7.6.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "7.6.0",
  git ? { },
}:
let
  versions = {
    "7.6.0" = import ./7.6.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "chewy: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "chewy: unknown version '${version}'")
