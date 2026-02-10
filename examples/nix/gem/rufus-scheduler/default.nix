#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rufus-scheduler
#
# Versions: 3.9.0, 3.9.1, 3.9.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.9.2",
  git ? { },
}:
let
  versions = {
    "3.9.0" = import ./3.9.0 { inherit lib stdenv ruby; };
    "3.9.1" = import ./3.9.1 { inherit lib stdenv ruby; };
    "3.9.2" = import ./3.9.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rufus-scheduler: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rufus-scheduler: unknown version '${version}'")
