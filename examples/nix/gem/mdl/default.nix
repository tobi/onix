#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mdl
#
# Versions: 0.12.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.12.0",
  git ? { },
}:
let
  versions = {
    "0.12.0" = import ./0.12.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mdl: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "mdl: unknown version '${version}'")
