#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubygems-bundler
#
# Versions: 1.4.5
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.4.5",
  git ? { },
}:
let
  versions = {
    "1.4.5" = import ./1.4.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rubygems-bundler: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rubygems-bundler: unknown version '${version}'")
