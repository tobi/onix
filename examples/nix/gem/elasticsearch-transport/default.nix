#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# elasticsearch-transport
#
# Versions: 7.17.9, 7.17.10, 7.17.11
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "7.17.11",
  git ? { },
}:
let
  versions = {
    "7.17.9" = import ./7.17.9 { inherit lib stdenv ruby; };
    "7.17.10" = import ./7.17.10 { inherit lib stdenv ruby; };
    "7.17.11" = import ./7.17.11 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "elasticsearch-transport: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "elasticsearch-transport: unknown version '${version}'")
