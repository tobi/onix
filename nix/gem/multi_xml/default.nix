#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# multi_xml
#
# Versions: 0.7.1, 0.7.2, 0.8.0, 0.8.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.8.1",
  git ? { },
}:
let
  versions = {
    "0.7.1" = import ./0.7.1 { inherit lib stdenv ruby; };
    "0.7.2" = import ./0.7.2 { inherit lib stdenv ruby; };
    "0.8.0" = import ./0.8.0 { inherit lib stdenv ruby; };
    "0.8.1" = import ./0.8.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "multi_xml: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "multi_xml: unknown version '${version}'")
