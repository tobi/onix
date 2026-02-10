#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop-minitest
#
# Versions: 0.37.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.37.1",
  git ? { },
}:
let
  versions = {
    "0.37.1" = import ./0.37.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rubocop-minitest: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rubocop-minitest: unknown version '${version}'")
