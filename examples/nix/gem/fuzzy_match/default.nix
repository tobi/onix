#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fuzzy_match
#
# Versions: 2.0.3, 2.0.4, 2.1.0
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
    "2.0.3" = import ./2.0.3 { inherit lib stdenv ruby; };
    "2.0.4" = import ./2.0.4 { inherit lib stdenv ruby; };
    "2.1.0" = import ./2.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "fuzzy_match: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "fuzzy_match: unknown version '${version}'")
