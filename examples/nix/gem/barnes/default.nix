#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# barnes
#
# Versions: 0.0.9
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.0.9",
  git ? { },
}:
let
  versions = {
    "0.0.9" = import ./0.0.9 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "barnes: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "barnes: unknown version '${version}'")
