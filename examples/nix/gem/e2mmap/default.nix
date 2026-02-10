#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# e2mmap
#
# Versions: 0.1.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.1.0",
  git ? { },
}:
let
  versions = {
    "0.1.0" = import ./0.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "e2mmap: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "e2mmap: unknown version '${version}'")
