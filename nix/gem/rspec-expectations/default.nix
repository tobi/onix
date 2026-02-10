#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rspec-expectations
#
# Versions: 3.12.4, 3.13.2, 3.13.3, 3.13.4, 3.13.5
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.13.5",
  git ? { },
}:
let
  versions = {
    "3.12.4" = import ./3.12.4 { inherit lib stdenv ruby; };
    "3.13.2" = import ./3.13.2 { inherit lib stdenv ruby; };
    "3.13.3" = import ./3.13.3 { inherit lib stdenv ruby; };
    "3.13.4" = import ./3.13.4 { inherit lib stdenv ruby; };
    "3.13.5" = import ./3.13.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rspec-expectations: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rspec-expectations: unknown version '${version}'")
