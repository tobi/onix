#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# capybara
#
# Versions: 3.37.1, 3.39.1, 3.39.2, 3.40.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.40.0",
  git ? { },
}:
let
  versions = {
    "3.37.1" = import ./3.37.1 { inherit lib stdenv ruby; };
    "3.39.1" = import ./3.39.1 { inherit lib stdenv ruby; };
    "3.39.2" = import ./3.39.2 { inherit lib stdenv ruby; };
    "3.40.0" = import ./3.40.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "capybara: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "capybara: unknown version '${version}'")
