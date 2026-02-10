#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# celluloid-supervision
#
# Versions: 0.20.1.1, 0.20.5, 0.20.6
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.20.6",
  git ? { },
}:
let
  versions = {
    "0.20.1.1" = import ./0.20.1.1 { inherit lib stdenv ruby; };
    "0.20.5" = import ./0.20.5 { inherit lib stdenv ruby; };
    "0.20.6" = import ./0.20.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "celluloid-supervision: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "celluloid-supervision: unknown version '${version}'")
