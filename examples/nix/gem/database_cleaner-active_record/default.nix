#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# database_cleaner-active_record
#
# Versions: 2.1.0, 2.2.0, 2.2.1, 2.2.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.2.2",
  git ? { },
}:
let
  versions = {
    "2.1.0" = import ./2.1.0 { inherit lib stdenv ruby; };
    "2.2.0" = import ./2.2.0 { inherit lib stdenv ruby; };
    "2.2.1" = import ./2.2.1 { inherit lib stdenv ruby; };
    "2.2.2" = import ./2.2.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "database_cleaner-active_record: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "database_cleaner-active_record: unknown version '${version}'")
