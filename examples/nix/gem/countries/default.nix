#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# countries
#
# Versions: 5.7.1, 8.0.3, 8.0.4, 8.1.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "8.1.0",
  git ? { },
}:
let
  versions = {
    "5.7.1" = import ./5.7.1 { inherit lib stdenv ruby; };
    "8.0.3" = import ./8.0.3 { inherit lib stdenv ruby; };
    "8.0.4" = import ./8.0.4 { inherit lib stdenv ruby; };
    "8.1.0" = import ./8.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "countries: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "countries: unknown version '${version}'")
