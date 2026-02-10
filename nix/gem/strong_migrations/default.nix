#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# strong_migrations
#
# Versions: 1.8.0, 2.5.0, 2.5.1, 2.5.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.5.2",
  git ? { },
}:
let
  versions = {
    "1.8.0" = import ./1.8.0 { inherit lib stdenv ruby; };
    "2.5.0" = import ./2.5.0 { inherit lib stdenv ruby; };
    "2.5.1" = import ./2.5.1 { inherit lib stdenv ruby; };
    "2.5.2" = import ./2.5.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "strong_migrations: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "strong_migrations: unknown version '${version}'")
