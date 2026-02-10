#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# database_cleaner
#
# Versions: 2.0.1, 2.0.2, 2.1.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.1.0",
  git ? { },
}:
let
  versions = {
    "2.0.1" = import ./2.0.1 { inherit lib stdenv ruby; };
    "2.0.2" = import ./2.0.2 { inherit lib stdenv ruby; };
    "2.1.0" = import ./2.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "database_cleaner: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "database_cleaner: unknown version '${version}'")
