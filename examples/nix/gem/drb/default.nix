#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# drb
#
# Versions: 2.2.0, 2.2.1, 2.2.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.2.3",
  git ? { },
}:
let
  versions = {
    "2.2.0" = import ./2.2.0 { inherit lib stdenv ruby; };
    "2.2.1" = import ./2.2.1 { inherit lib stdenv ruby; };
    "2.2.3" = import ./2.2.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "drb: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "drb: unknown version '${version}'")
