#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cuprite
#
# Versions: 0.15
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.15",
  git ? { },
}:
let
  versions = {
    "0.15" = import ./0.15 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "cuprite: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "cuprite: unknown version '${version}'")
