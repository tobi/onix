#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# js-routes
#
# Versions: 2.2.8
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.2.8",
  git ? { },
}:
let
  versions = {
    "2.2.8" = import ./2.2.8 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "js-routes: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "js-routes: unknown version '${version}'")
