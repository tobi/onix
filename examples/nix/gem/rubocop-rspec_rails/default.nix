#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop-rspec_rails
#
# Versions: 2.28.3, 2.32.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.32.0",
  git ? { },
}:
let
  versions = {
    "2.28.3" = import ./2.28.3 { inherit lib stdenv ruby; };
    "2.32.0" = import ./2.32.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rubocop-rspec_rails: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rubocop-rspec_rails: unknown version '${version}'")
