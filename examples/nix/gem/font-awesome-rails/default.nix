#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# font-awesome-rails
#
# Versions: 4.7.0.7, 4.7.0.8, 4.7.0.9
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.7.0.9",
  git ? { },
}:
let
  versions = {
    "4.7.0.7" = import ./4.7.0.7 { inherit lib stdenv ruby; };
    "4.7.0.8" = import ./4.7.0.8 { inherit lib stdenv ruby; };
    "4.7.0.9" = import ./4.7.0.9 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "font-awesome-rails: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "font-awesome-rails: unknown version '${version}'")
