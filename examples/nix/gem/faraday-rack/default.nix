#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faraday-rack
#
# Versions: 2.0.0, 2.1.2, 2.1.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.1.3",
  git ? { },
}:
let
  versions = {
    "2.0.0" = import ./2.0.0 { inherit lib stdenv ruby; };
    "2.1.2" = import ./2.1.2 { inherit lib stdenv ruby; };
    "2.1.3" = import ./2.1.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "faraday-rack: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "faraday-rack: unknown version '${version}'")
