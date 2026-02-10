#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# feedjira
#
# Versions: 3.2.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.2.3",
  git ? { },
}:
let
  versions = {
    "3.2.3" = import ./3.2.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "feedjira: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "feedjira: unknown version '${version}'")
