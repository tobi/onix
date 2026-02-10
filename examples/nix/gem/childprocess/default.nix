#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# childprocess
#
# Versions: 4.1.0, 5.0.0, 5.1.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.1.0",
  git ? { },
}:
let
  versions = {
    "4.1.0" = import ./4.1.0 { inherit lib stdenv ruby; };
    "5.0.0" = import ./5.0.0 { inherit lib stdenv ruby; };
    "5.1.0" = import ./5.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "childprocess: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "childprocess: unknown version '${version}'")
