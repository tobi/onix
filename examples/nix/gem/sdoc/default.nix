#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sdoc
#
# Versions: 2.6.3, 2.6.4, 2.6.5
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.6.5",
  git ? { },
}:
let
  versions = {
    "2.6.3" = import ./2.6.3 { inherit lib stdenv ruby; };
    "2.6.4" = import ./2.6.4 { inherit lib stdenv ruby; };
    "2.6.5" = import ./2.6.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sdoc: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "sdoc: unknown version '${version}'")
