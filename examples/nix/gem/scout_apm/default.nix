#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# scout_apm
#
# Versions: 5.3.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.3.3",
  git ? { },
}:
let
  versions = {
    "5.3.3" = import ./5.3.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "scout_apm: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "scout_apm: unknown version '${version}'")
