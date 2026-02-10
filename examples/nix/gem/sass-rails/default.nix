#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sass-rails
#
# Versions: 5.0.8, 5.1.0, 6.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.0.0",
  git ? { },
}:
let
  versions = {
    "5.0.8" = import ./5.0.8 { inherit lib stdenv ruby; };
    "5.1.0" = import ./5.1.0 { inherit lib stdenv ruby; };
    "6.0.0" = import ./6.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sass-rails: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "sass-rails: unknown version '${version}'")
