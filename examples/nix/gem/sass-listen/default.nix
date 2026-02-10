#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sass-listen
#
# Versions: 3.0.7, 4.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.0.0",
  git ? { },
}:
let
  versions = {
    "3.0.7" = import ./3.0.7 { inherit lib stdenv ruby; };
    "4.0.0" = import ./4.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sass-listen: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "sass-listen: unknown version '${version}'")
