#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# danger
#
# Versions: 9.5.1, 9.5.2, 9.5.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "9.5.3",
  git ? { },
}:
let
  versions = {
    "9.5.1" = import ./9.5.1 { inherit lib stdenv ruby; };
    "9.5.2" = import ./9.5.2 { inherit lib stdenv ruby; };
    "9.5.3" = import ./9.5.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "danger: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "danger: unknown version '${version}'")
