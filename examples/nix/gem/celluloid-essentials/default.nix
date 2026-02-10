#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# celluloid-essentials
#
# Versions: 0.20.2, 0.20.2.1, 0.20.5
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.20.5",
  git ? { },
}:
let
  versions = {
    "0.20.2" = import ./0.20.2 { inherit lib stdenv ruby; };
    "0.20.2.1" = import ./0.20.2.1 { inherit lib stdenv ruby; };
    "0.20.5" = import ./0.20.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "celluloid-essentials: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "celluloid-essentials: unknown version '${version}'")
