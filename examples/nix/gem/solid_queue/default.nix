#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# solid_queue
#
# Versions: 1.1.2, 1.2.4
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.4",
  git ? { },
}:
let
  versions = {
    "1.1.2" = import ./1.1.2 { inherit lib stdenv ruby; };
    "1.2.4" = import ./1.2.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "solid_queue: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "solid_queue: unknown version '${version}'")
