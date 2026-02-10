#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# licensee
#
# Versions: 9.17.0, 9.17.1, 9.18.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "9.18.0",
  git ? { },
}:
let
  versions = {
    "9.17.0" = import ./9.17.0 { inherit lib stdenv ruby; };
    "9.17.1" = import ./9.17.1 { inherit lib stdenv ruby; };
    "9.18.0" = import ./9.18.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "licensee: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "licensee: unknown version '${version}'")
