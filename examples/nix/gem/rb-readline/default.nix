#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rb-readline
#
# Versions: 0.5.3, 0.5.4, 0.5.5
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.5.5",
  git ? { },
}:
let
  versions = {
    "0.5.3" = import ./0.5.3 { inherit lib stdenv ruby; };
    "0.5.4" = import ./0.5.4 { inherit lib stdenv ruby; };
    "0.5.5" = import ./0.5.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rb-readline: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rb-readline: unknown version '${version}'")
