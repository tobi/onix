#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# autoprefixer-rails
#
# Versions: 10.4.16.0, 10.4.19.0, 10.4.21.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "10.4.21.0",
  git ? { },
}:
let
  versions = {
    "10.4.16.0" = import ./10.4.16.0 { inherit lib stdenv ruby; };
    "10.4.19.0" = import ./10.4.19.0 { inherit lib stdenv ruby; };
    "10.4.21.0" = import ./10.4.21.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "autoprefixer-rails: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "autoprefixer-rails: unknown version '${version}'")
