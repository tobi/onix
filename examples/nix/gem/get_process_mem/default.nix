#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# get_process_mem
#
# Versions: 0.2.6, 0.2.7, 1.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.0",
  git ? { },
}:
let
  versions = {
    "0.2.6" = import ./0.2.6 { inherit lib stdenv ruby; };
    "0.2.7" = import ./0.2.7 { inherit lib stdenv ruby; };
    "1.0.0" = import ./1.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "get_process_mem: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "get_process_mem: unknown version '${version}'")
