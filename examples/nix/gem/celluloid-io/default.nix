#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# celluloid-io
#
# Versions: 0.17.1, 0.17.2, 0.17.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.17.3",
  git ? { },
}:
let
  versions = {
    "0.17.1" = import ./0.17.1 { inherit lib stdenv ruby; };
    "0.17.2" = import ./0.17.2 { inherit lib stdenv ruby; };
    "0.17.3" = import ./0.17.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "celluloid-io: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "celluloid-io: unknown version '${version}'")
