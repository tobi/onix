#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# logster
#
# Versions: 2.20.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.20.1",
  git ? { },
}:
let
  versions = {
    "2.20.1" = import ./2.20.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "logster: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "logster: unknown version '${version}'")
