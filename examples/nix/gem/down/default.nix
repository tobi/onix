#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# down
#
# Versions: 5.4.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.4.0",
  git ? { },
}:
let
  versions = {
    "5.4.0" = import ./5.4.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "down: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "down: unknown version '${version}'")
