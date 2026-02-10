#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# timeliness
#
# Versions: 0.5.1, 0.5.2, 0.5.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.5.3",
  git ? { },
}:
let
  versions = {
    "0.5.1" = import ./0.5.1 { inherit lib stdenv ruby; };
    "0.5.2" = import ./0.5.2 { inherit lib stdenv ruby; };
    "0.5.3" = import ./0.5.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "timeliness: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "timeliness: unknown version '${version}'")
