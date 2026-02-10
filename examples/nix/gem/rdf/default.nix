#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rdf
#
# Versions: 3.3.4
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.3.4",
  git ? { },
}:
let
  versions = {
    "3.3.4" = import ./3.3.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rdf: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rdf: unknown version '${version}'")
