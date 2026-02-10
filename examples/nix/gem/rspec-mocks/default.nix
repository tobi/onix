#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rspec-mocks
#
# Versions: 3.12.7, 3.13.1, 3.13.5, 3.13.6, 3.13.7
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.13.7",
  git ? { },
}:
let
  versions = {
    "3.12.7" = import ./3.12.7 { inherit lib stdenv ruby; };
    "3.13.1" = import ./3.13.1 { inherit lib stdenv ruby; };
    "3.13.5" = import ./3.13.5 { inherit lib stdenv ruby; };
    "3.13.6" = import ./3.13.6 { inherit lib stdenv ruby; };
    "3.13.7" = import ./3.13.7 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rspec-mocks: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rspec-mocks: unknown version '${version}'")
