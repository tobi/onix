#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# irb
#
# Versions: 1.7.2, 1.12.0, 1.15.2, 1.15.3, 1.16.0, 1.17.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.17.0",
  git ? { },
}:
let
  versions = {
    "1.7.2" = import ./1.7.2 { inherit lib stdenv ruby; };
    "1.12.0" = import ./1.12.0 { inherit lib stdenv ruby; };
    "1.15.2" = import ./1.15.2 { inherit lib stdenv ruby; };
    "1.15.3" = import ./1.15.3 { inherit lib stdenv ruby; };
    "1.16.0" = import ./1.16.0 { inherit lib stdenv ruby; };
    "1.17.0" = import ./1.17.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "irb: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "irb: unknown version '${version}'")
