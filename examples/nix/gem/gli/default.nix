#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# gli
#
# Versions: 2.22.0, 2.22.1, 2.22.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.22.2",
  git ? { },
}:
let
  versions = {
    "2.22.0" = import ./2.22.0 { inherit lib stdenv ruby; };
    "2.22.1" = import ./2.22.1 { inherit lib stdenv ruby; };
    "2.22.2" = import ./2.22.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "gli: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "gli: unknown version '${version}'")
