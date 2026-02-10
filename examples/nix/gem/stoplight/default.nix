#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# stoplight
#
# Versions: 5.7.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.7.0",
  git ? { },
}:
let
  versions = {
    "5.7.0" = import ./5.7.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "stoplight: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "stoplight: unknown version '${version}'")
