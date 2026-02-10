#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# seed-fu
#
# Versions: 2.3.6, 2.3.7, 2.3.9
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.3.9",
  git ? { },
}:
let
  versions = {
    "2.3.6" = import ./2.3.6 { inherit lib stdenv ruby; };
    "2.3.7" = import ./2.3.7 { inherit lib stdenv ruby; };
    "2.3.9" = import ./2.3.9 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "seed-fu: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "seed-fu: unknown version '${version}'")
