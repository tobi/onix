#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# teaspoon-mocha
#
# Versions: 2.3.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.3.3",
  git ? { },
}:
let
  versions = {
    "2.3.3" = import ./2.3.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "teaspoon-mocha: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "teaspoon-mocha: unknown version '${version}'")
