#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pg_search
#
# Versions: 2.3.6
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.3.6",
  git ? { },
}:
let
  versions = {
    "2.3.6" = import ./2.3.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "pg_search: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "pg_search: unknown version '${version}'")
