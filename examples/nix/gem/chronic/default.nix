#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# chronic
#
# Versions: 0.10.0, 0.10.1, 0.10.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.10.2",
  git ? { },
}:
let
  versions = {
    "0.10.0" = import ./0.10.0 { inherit lib stdenv ruby; };
    "0.10.1" = import ./0.10.1 { inherit lib stdenv ruby; };
    "0.10.2" = import ./0.10.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "chronic: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "chronic: unknown version '${version}'")
