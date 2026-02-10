#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# backburner
#
# Versions: 1.7.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.7.0",
  git ? { },
}:
let
  versions = {
    "1.7.0" = import ./1.7.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "backburner: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "backburner: unknown version '${version}'")
