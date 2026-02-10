#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# set
#
# Versions: 1.1.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.1.2",
  git ? { },
}:
let
  versions = {
    "1.1.2" = import ./1.1.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "set: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "set: unknown version '${version}'")
