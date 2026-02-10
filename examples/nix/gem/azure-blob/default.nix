#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# azure-blob
#
# Versions: 0.5.9.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.5.9.1",
  git ? { },
}:
let
  versions = {
    "0.5.9.1" = import ./0.5.9.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "azure-blob: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "azure-blob: unknown version '${version}'")
