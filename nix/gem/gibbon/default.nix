#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# gibbon
#
# Versions: 3.5.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.5.0",
  git ? { },
}:
let
  versions = {
    "3.5.0" = import ./3.5.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "gibbon: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "gibbon: unknown version '${version}'")
