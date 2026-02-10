#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# turbo-rails
#
# Versions: 2.0.11, 2.0.21, 2.0.22, 2.0.23
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.0.23",
  git ? { },
}:
let
  versions = {
    "2.0.11" = import ./2.0.11 { inherit lib stdenv ruby; };
    "2.0.21" = import ./2.0.21 { inherit lib stdenv ruby; };
    "2.0.22" = import ./2.0.22 { inherit lib stdenv ruby; };
    "2.0.23" = import ./2.0.23 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "turbo-rails: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "turbo-rails: unknown version '${version}'")
