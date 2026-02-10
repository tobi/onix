#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# resque-scheduler
#
# Versions: 4.11.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.11.0",
  git ? { },
}:
let
  versions = {
    "4.11.0" = import ./4.11.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "resque-scheduler: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "resque-scheduler: unknown version '${version}'")
