#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# dotenv-rails
#
# Versions: 2.8.1, 3.1.2, 3.1.7, 3.1.8, 3.2.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.2.0",
  git ? { },
}:
let
  versions = {
    "2.8.1" = import ./2.8.1 { inherit lib stdenv ruby; };
    "3.1.2" = import ./3.1.2 { inherit lib stdenv ruby; };
    "3.1.7" = import ./3.1.7 { inherit lib stdenv ruby; };
    "3.1.8" = import ./3.1.8 { inherit lib stdenv ruby; };
    "3.2.0" = import ./3.2.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "dotenv-rails: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "dotenv-rails: unknown version '${version}'")
