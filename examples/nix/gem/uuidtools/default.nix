#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# uuidtools
#
# Versions: 2.1.5, 2.2.0, 3.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.0.0",
  git ? { },
}:
let
  versions = {
    "2.1.5" = import ./2.1.5 { inherit lib stdenv ruby; };
    "2.2.0" = import ./2.2.0 { inherit lib stdenv ruby; };
    "3.0.0" = import ./3.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "uuidtools: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "uuidtools: unknown version '${version}'")
