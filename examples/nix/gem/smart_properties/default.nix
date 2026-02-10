#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# smart_properties
#
# Versions: 1.17.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.17.0",
  git ? { },
}:
let
  versions = {
    "1.17.0" = import ./1.17.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "smart_properties: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "smart_properties: unknown version '${version}'")
