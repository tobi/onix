#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# money-rails
#
# Versions: 1.15.0, 2.0.0, 3.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.0.0",
  git ? { },
}:
let
  versions = {
    "1.15.0" = import ./1.15.0 { inherit lib stdenv ruby; };
    "2.0.0" = import ./2.0.0 { inherit lib stdenv ruby; };
    "3.0.0" = import ./3.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "money-rails: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "money-rails: unknown version '${version}'")
