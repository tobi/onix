#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ddtrace
#
# Versions: 1.16.2, 1.23.1, 1.23.2, 1.23.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.23.3",
  git ? { },
}:
let
  versions = {
    "1.16.2" = import ./1.16.2 { inherit lib stdenv ruby pkgs; };
    "1.23.1" = import ./1.23.1 { inherit lib stdenv ruby pkgs; };
    "1.23.2" = import ./1.23.2 { inherit lib stdenv ruby pkgs; };
    "1.23.3" = import ./1.23.3 { inherit lib stdenv ruby pkgs; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ddtrace: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "ddtrace: unknown version '${version}'")
