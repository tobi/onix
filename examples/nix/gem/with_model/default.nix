#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# with_model
#
# Versions: 2.1.7
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.1.7",
  git ? { },
}:
let
  versions = {
    "2.1.7" = import ./2.1.7 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "with_model: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "with_model: unknown version '${version}'")
