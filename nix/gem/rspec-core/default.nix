#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rspec-core
#
# Versions: 3.12.3, 3.13.0, 3.13.4, 3.13.5, 3.13.6
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.13.6",
  git ? { },
}:
let
  versions = {
    "3.12.3" = import ./3.12.3 { inherit lib stdenv ruby; };
    "3.13.0" = import ./3.13.0 { inherit lib stdenv ruby; };
    "3.13.4" = import ./3.13.4 { inherit lib stdenv ruby; };
    "3.13.5" = import ./3.13.5 { inherit lib stdenv ruby; };
    "3.13.6" = import ./3.13.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rspec-core: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rspec-core: unknown version '${version}'")
