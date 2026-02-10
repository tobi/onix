#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# phonelib
#
# Versions: 0.10.14, 0.10.15, 0.10.16
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.10.16",
  git ? { },
}:
let
  versions = {
    "0.10.14" = import ./0.10.14 { inherit lib stdenv ruby; };
    "0.10.15" = import ./0.10.15 { inherit lib stdenv ruby; };
    "0.10.16" = import ./0.10.16 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "phonelib: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "phonelib: unknown version '${version}'")
