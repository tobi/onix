#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# timeout
#
# Versions: 0.4.1, 0.4.3, 0.4.4, 0.5.0, 0.6.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.6.0",
  git ? { },
}:
let
  versions = {
    "0.4.1" = import ./0.4.1 { inherit lib stdenv ruby; };
    "0.4.3" = import ./0.4.3 { inherit lib stdenv ruby; };
    "0.4.4" = import ./0.4.4 { inherit lib stdenv ruby; };
    "0.5.0" = import ./0.5.0 { inherit lib stdenv ruby; };
    "0.6.0" = import ./0.6.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "timeout: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "timeout: unknown version '${version}'")
