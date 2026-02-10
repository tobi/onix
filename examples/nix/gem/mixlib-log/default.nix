#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mixlib-log
#
# Versions: 3.1.2.1, 3.2.0, 3.2.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.2.3",
  git ? { },
}:
let
  versions = {
    "3.1.2.1" = import ./3.1.2.1 { inherit lib stdenv ruby; };
    "3.2.0" = import ./3.2.0 { inherit lib stdenv ruby; };
    "3.2.3" = import ./3.2.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mixlib-log: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "mixlib-log: unknown version '${version}'")
