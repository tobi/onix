#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# kostya-sigar
#
# Versions: 2.0.9, 2.0.10, 2.0.11
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.0.11",
  git ? { },
}:
let
  versions = {
    "2.0.9" = import ./2.0.9 { inherit lib stdenv ruby; };
    "2.0.10" = import ./2.0.10 { inherit lib stdenv ruby; };
    "2.0.11" = import ./2.0.11 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "kostya-sigar: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "kostya-sigar: unknown version '${version}'")
