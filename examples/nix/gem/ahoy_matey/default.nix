#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ahoy_matey
#
# Versions: 5.0.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.0.2",
  git ? { },
}:
let
  versions = {
    "5.0.2" = import ./5.0.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ahoy_matey: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "ahoy_matey: unknown version '${version}'")
