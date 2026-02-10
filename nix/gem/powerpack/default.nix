#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# powerpack
#
# Versions: 0.1.1, 0.1.2, 0.1.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.1.3",
  git ? { },
}:
let
  versions = {
    "0.1.1" = import ./0.1.1 { inherit lib stdenv ruby; };
    "0.1.2" = import ./0.1.2 { inherit lib stdenv ruby; };
    "0.1.3" = import ./0.1.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "powerpack: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "powerpack: unknown version '${version}'")
