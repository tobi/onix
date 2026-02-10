#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# facter
#
# Versions: 4.8.0, 4.9.0, 4.10.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.10.0",
  git ? { },
}:
let
  versions = {
    "4.8.0" = import ./4.8.0 { inherit lib stdenv ruby; };
    "4.9.0" = import ./4.9.0 { inherit lib stdenv ruby; };
    "4.10.0" = import ./4.10.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "facter: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "facter: unknown version '${version}'")
