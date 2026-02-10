#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# actionpack-xml_parser
#
# Versions: 2.0.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.0.1",
  git ? { },
}:
let
  versions = {
    "2.0.1" = import ./2.0.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "actionpack-xml_parser: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "actionpack-xml_parser: unknown version '${version}'")
