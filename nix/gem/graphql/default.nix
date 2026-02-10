#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# graphql
#
# Versions: 2.5.17, 2.5.18, 2.5.19
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.5.19",
  git ? { },
}:
let
  versions = {
    "2.5.17" = import ./2.5.17 { inherit lib stdenv ruby; };
    "2.5.18" = import ./2.5.18 { inherit lib stdenv ruby; };
    "2.5.19" = import ./2.5.19 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "graphql: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "graphql: unknown version '${version}'")
