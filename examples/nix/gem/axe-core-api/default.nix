#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# axe-core-api
#
# Versions: 4.11.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.11.1",
  git ? { },
}:
let
  versions = {
    "4.11.1" = import ./4.11.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "axe-core-api: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "axe-core-api: unknown version '${version}'")
