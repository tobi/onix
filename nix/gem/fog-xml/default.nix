#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fog-xml
#
# Versions: 0.1.3, 0.1.4, 0.1.5
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.1.5",
  git ? { },
}:
let
  versions = {
    "0.1.3" = import ./0.1.3 { inherit lib stdenv ruby; };
    "0.1.4" = import ./0.1.4 { inherit lib stdenv ruby; };
    "0.1.5" = import ./0.1.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "fog-xml: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "fog-xml: unknown version '${version}'")
