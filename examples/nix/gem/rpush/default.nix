#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rpush
#
# Versions: 7.0.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "7.0.1",
  git ? { },
}:
let
  versions = {
    "7.0.1" = import ./7.0.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rpush: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rpush: unknown version '${version}'")
