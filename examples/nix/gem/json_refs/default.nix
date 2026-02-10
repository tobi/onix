#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# json_refs
#
# Versions: 0.1.8
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.1.8",
  git ? { },
}:
let
  versions = {
    "0.1.8" = import ./0.1.8 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "json_refs: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "json_refs: unknown version '${version}'")
