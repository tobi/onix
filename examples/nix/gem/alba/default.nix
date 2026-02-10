#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# alba
#
# Versions: 3.10.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.10.0",
  git ? { },
}:
let
  versions = {
    "3.10.0" = import ./3.10.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "alba: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "alba: unknown version '${version}'")
