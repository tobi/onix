#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# temple
#
# Versions: 0.10.2, 0.10.3, 0.10.4
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.10.4",
  git ? { },
}:
let
  versions = {
    "0.10.2" = import ./0.10.2 { inherit lib stdenv ruby; };
    "0.10.3" = import ./0.10.3 { inherit lib stdenv ruby; };
    "0.10.4" = import ./0.10.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "temple: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "temple: unknown version '${version}'")
