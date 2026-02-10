#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# unf
#
# Versions: 0.1.3, 0.1.4, 0.2.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.2.0",
  git ? { },
}:
let
  versions = {
    "0.1.3" = import ./0.1.3 { inherit lib stdenv ruby; };
    "0.1.4" = import ./0.1.4 { inherit lib stdenv ruby; };
    "0.2.0" = import ./0.2.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "unf: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "unf: unknown version '${version}'")
