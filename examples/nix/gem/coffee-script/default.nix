#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# coffee-script
#
# Versions: 2.3.0, 2.4.0, 2.4.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.4.1",
  git ? { },
}:
let
  versions = {
    "2.3.0" = import ./2.3.0 { inherit lib stdenv ruby; };
    "2.4.0" = import ./2.4.0 { inherit lib stdenv ruby; };
    "2.4.1" = import ./2.4.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "coffee-script: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "coffee-script: unknown version '${version}'")
