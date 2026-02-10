#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# thrift
#
# Versions: 0.20.0, 0.21.0, 0.22.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.22.0",
  git ? { },
}:
let
  versions = {
    "0.20.0" = import ./0.20.0 { inherit lib stdenv ruby; };
    "0.21.0" = import ./0.21.0 { inherit lib stdenv ruby; };
    "0.22.0" = import ./0.22.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "thrift: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "thrift: unknown version '${version}'")
