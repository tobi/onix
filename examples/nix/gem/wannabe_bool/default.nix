#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# wannabe_bool
#
# Versions: 0.7.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.7.1",
  git ? { },
}:
let
  versions = {
    "0.7.1" = import ./0.7.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "wannabe_bool: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "wannabe_bool: unknown version '${version}'")
