#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pgvector
#
# Versions: 0.1.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.1.1",
  git ? { },
}:
let
  versions = {
    "0.1.1" = import ./0.1.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "pgvector: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "pgvector: unknown version '${version}'")
