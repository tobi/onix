#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# declarative
#
# Versions: 0.0.9, 0.0.10, 0.0.20
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.0.20",
  git ? { },
}:
let
  versions = {
    "0.0.9" = import ./0.0.9 { inherit lib stdenv ruby; };
    "0.0.10" = import ./0.0.10 { inherit lib stdenv ruby; };
    "0.0.20" = import ./0.0.20 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "declarative: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "declarative: unknown version '${version}'")
