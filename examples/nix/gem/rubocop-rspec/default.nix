#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop-rspec
#
# Versions: 2.29.1, 3.6.0, 3.7.0, 3.8.0, 3.9.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.9.0",
  git ? { },
}:
let
  versions = {
    "2.29.1" = import ./2.29.1 { inherit lib stdenv ruby; };
    "3.6.0" = import ./3.6.0 { inherit lib stdenv ruby; };
    "3.7.0" = import ./3.7.0 { inherit lib stdenv ruby; };
    "3.8.0" = import ./3.8.0 { inherit lib stdenv ruby; };
    "3.9.0" = import ./3.9.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rubocop-rspec: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rubocop-rspec: unknown version '${version}'")
