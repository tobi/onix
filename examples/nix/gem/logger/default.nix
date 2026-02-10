#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# logger
#
# Versions: 1.6.5, 1.6.6, 1.7.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.7.0",
  git ? { },
}:
let
  versions = {
    "1.6.5" = import ./1.6.5 { inherit lib stdenv ruby; };
    "1.6.6" = import ./1.6.6 { inherit lib stdenv ruby; };
    "1.7.0" = import ./1.7.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "logger: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "logger: unknown version '${version}'")
