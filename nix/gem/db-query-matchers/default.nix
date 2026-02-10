#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# db-query-matchers
#
# Versions: 0.15.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.15.0",
  git ? { },
}:
let
  versions = {
    "0.15.0" = import ./0.15.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "db-query-matchers: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "db-query-matchers: unknown version '${version}'")
