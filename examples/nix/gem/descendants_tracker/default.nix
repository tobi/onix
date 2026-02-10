#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# descendants_tracker
#
# Versions: 0.0.2, 0.0.3, 0.0.4
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.0.4",
  git ? { },
}:
let
  versions = {
    "0.0.2" = import ./0.0.2 { inherit lib stdenv ruby; };
    "0.0.3" = import ./0.0.3 { inherit lib stdenv ruby; };
    "0.0.4" = import ./0.0.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "descendants_tracker: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "descendants_tracker: unknown version '${version}'")
