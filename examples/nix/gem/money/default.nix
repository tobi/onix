#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# money
#
# Versions: 6.19.0, 7.0.0, 7.0.1, 7.0.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "7.0.2",
  git ? { },
}:
let
  versions = {
    "6.19.0" = import ./6.19.0 { inherit lib stdenv ruby; };
    "7.0.0" = import ./7.0.0 { inherit lib stdenv ruby; };
    "7.0.1" = import ./7.0.1 { inherit lib stdenv ruby; };
    "7.0.2" = import ./7.0.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "money: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "money: unknown version '${version}'")
