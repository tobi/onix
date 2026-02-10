#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# roo
#
# Versions: 2.10.0, 2.10.1, 3.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.0.0",
  git ? { },
}:
let
  versions = {
    "2.10.0" = import ./2.10.0 { inherit lib stdenv ruby; };
    "2.10.1" = import ./2.10.1 { inherit lib stdenv ruby; };
    "3.0.0" = import ./3.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "roo: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "roo: unknown version '${version}'")
