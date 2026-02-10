#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rspec
#
# Versions: 3.12.0, 3.13.0, 3.13.1, 3.13.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.13.2",
  git ? { },
}:
let
  versions = {
    "3.12.0" = import ./3.12.0 { inherit lib stdenv ruby; };
    "3.13.0" = import ./3.13.0 { inherit lib stdenv ruby; };
    "3.13.1" = import ./3.13.1 { inherit lib stdenv ruby; };
    "3.13.2" = import ./3.13.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rspec: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rspec: unknown version '${version}'")
