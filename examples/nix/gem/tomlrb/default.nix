#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tomlrb
#
# Versions: 2.0.2, 2.0.3, 2.0.4
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.0.4",
  git ? { },
}:
let
  versions = {
    "2.0.2" = import ./2.0.2 { inherit lib stdenv ruby; };
    "2.0.3" = import ./2.0.3 { inherit lib stdenv ruby; };
    "2.0.4" = import ./2.0.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "tomlrb: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "tomlrb: unknown version '${version}'")
