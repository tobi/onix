#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# monetize
#
# Versions: 1.12.0, 1.13.0, 2.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.0.0",
  git ? { },
}:
let
  versions = {
    "1.12.0" = import ./1.12.0 { inherit lib stdenv ruby; };
    "1.13.0" = import ./1.13.0 { inherit lib stdenv ruby; };
    "2.0.0" = import ./2.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "monetize: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "monetize: unknown version '${version}'")
