#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# coffee-rails
#
# Versions: 4.2.1, 4.2.2, 5.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.0.0",
  git ? { },
}:
let
  versions = {
    "4.2.1" = import ./4.2.1 { inherit lib stdenv ruby; };
    "4.2.2" = import ./4.2.2 { inherit lib stdenv ruby; };
    "5.0.0" = import ./5.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "coffee-rails: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "coffee-rails: unknown version '${version}'")
