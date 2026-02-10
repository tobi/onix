#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pg_query
#
# Versions: 4.2.3, 6.1.0, 6.2.1, 6.2.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.2.2",
  git ? { },
}:
let
  versions = {
    "4.2.3" = import ./4.2.3 { inherit lib stdenv ruby; };
    "6.1.0" = import ./6.1.0 { inherit lib stdenv ruby; };
    "6.2.1" = import ./6.2.1 { inherit lib stdenv ruby; };
    "6.2.2" = import ./6.2.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "pg_query: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "pg_query: unknown version '${version}'")
