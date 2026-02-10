#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# brakeman
#
# Versions: 5.4.1, 7.0.0, 7.1.2, 8.0.0, 8.0.1, 8.0.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "8.0.2",
  git ? { },
}:
let
  versions = {
    "5.4.1" = import ./5.4.1 { inherit lib stdenv ruby; };
    "7.0.0" = import ./7.0.0 { inherit lib stdenv ruby; };
    "7.1.2" = import ./7.1.2 { inherit lib stdenv ruby; };
    "8.0.0" = import ./8.0.0 { inherit lib stdenv ruby; };
    "8.0.1" = import ./8.0.1 { inherit lib stdenv ruby; };
    "8.0.2" = import ./8.0.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "brakeman: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "brakeman: unknown version '${version}'")
