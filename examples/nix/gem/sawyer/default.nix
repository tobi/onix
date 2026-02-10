#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sawyer
#
# Versions: 0.9.1, 0.9.2, 0.9.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.9.3",
  git ? { },
}:
let
  versions = {
    "0.9.1" = import ./0.9.1 { inherit lib stdenv ruby; };
    "0.9.2" = import ./0.9.2 { inherit lib stdenv ruby; };
    "0.9.3" = import ./0.9.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sawyer: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "sawyer: unknown version '${version}'")
