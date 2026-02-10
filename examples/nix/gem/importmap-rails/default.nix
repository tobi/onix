#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# importmap-rails
#
# Versions: 2.1.0, 2.2.2, 2.2.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.2.3",
  git ? { },
}:
let
  versions = {
    "2.1.0" = import ./2.1.0 { inherit lib stdenv ruby; };
    "2.2.2" = import ./2.2.2 { inherit lib stdenv ruby; };
    "2.2.3" = import ./2.2.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "importmap-rails: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "importmap-rails: unknown version '${version}'")
