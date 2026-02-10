#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# snaky_hash
#
# Versions: 2.0.1, 2.0.2, 2.0.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.0.3",
  git ? { },
}:
let
  versions = {
    "2.0.1" = import ./2.0.1 { inherit lib stdenv ruby; };
    "2.0.2" = import ./2.0.2 { inherit lib stdenv ruby; };
    "2.0.3" = import ./2.0.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "snaky_hash: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "snaky_hash: unknown version '${version}'")
