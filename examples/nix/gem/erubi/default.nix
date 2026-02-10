#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# erubi
#
# Versions: 1.12.0, 1.13.0, 1.13.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.13.1",
  git ? { },
}:
let
  versions = {
    "1.12.0" = import ./1.12.0 { inherit lib stdenv ruby; };
    "1.13.0" = import ./1.13.0 { inherit lib stdenv ruby; };
    "1.13.1" = import ./1.13.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "erubi: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "erubi: unknown version '${version}'")
