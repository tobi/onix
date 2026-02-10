#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# groupdate
#
# Versions: 6.2.1, 6.7.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.7.0",
  git ? { },
}:
let
  versions = {
    "6.2.1" = import ./6.2.1 { inherit lib stdenv ruby; };
    "6.7.0" = import ./6.7.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "groupdate: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "groupdate: unknown version '${version}'")
