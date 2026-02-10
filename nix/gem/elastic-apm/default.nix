#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# elastic-apm
#
# Versions: 4.6.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.6.2",
  git ? { },
}:
let
  versions = {
    "4.6.2" = import ./4.6.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "elastic-apm: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "elastic-apm: unknown version '${version}'")
