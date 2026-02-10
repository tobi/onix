#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rouge
#
# Versions: 4.2.1, 4.6.0, 4.6.1, 4.7.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.7.0",
  git ? { },
}:
let
  versions = {
    "4.2.1" = import ./4.2.1 { inherit lib stdenv ruby; };
    "4.6.0" = import ./4.6.0 { inherit lib stdenv ruby; };
    "4.6.1" = import ./4.6.1 { inherit lib stdenv ruby; };
    "4.7.0" = import ./4.7.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rouge: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rouge: unknown version '${version}'")
