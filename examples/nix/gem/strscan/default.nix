#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# strscan
#
# Versions: 3.1.5, 3.1.6, 3.1.7
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.1.7",
  git ? { },
}:
let
  versions = {
    "3.1.5" = import ./3.1.5 { inherit lib stdenv ruby; };
    "3.1.6" = import ./3.1.6 { inherit lib stdenv ruby; };
    "3.1.7" = import ./3.1.7 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "strscan: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "strscan: unknown version '${version}'")
