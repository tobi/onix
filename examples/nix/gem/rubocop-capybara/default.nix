#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop-capybara
#
# Versions: 2.20.0, 2.21.0, 2.22.0, 2.22.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.22.1",
  git ? { },
}:
let
  versions = {
    "2.20.0" = import ./2.20.0 { inherit lib stdenv ruby; };
    "2.21.0" = import ./2.21.0 { inherit lib stdenv ruby; };
    "2.22.0" = import ./2.22.0 { inherit lib stdenv ruby; };
    "2.22.1" = import ./2.22.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rubocop-capybara: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rubocop-capybara: unknown version '${version}'")
