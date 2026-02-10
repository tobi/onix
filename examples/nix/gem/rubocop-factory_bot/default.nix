#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop-factory_bot
#
# Versions: 2.25.1, 2.27.0, 2.27.1, 2.28.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.28.0",
  git ? { },
}:
let
  versions = {
    "2.25.1" = import ./2.25.1 { inherit lib stdenv ruby; };
    "2.27.0" = import ./2.27.0 { inherit lib stdenv ruby; };
    "2.27.1" = import ./2.27.1 { inherit lib stdenv ruby; };
    "2.28.0" = import ./2.28.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rubocop-factory_bot: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rubocop-factory_bot: unknown version '${version}'")
