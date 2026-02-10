#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rspec-rails
#
# Versions: 6.0.4, 6.1.1, 7.0.1, 8.0.0, 8.0.1, 8.0.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "8.0.2",
  git ? { },
}:
let
  versions = {
    "6.0.4" = import ./6.0.4 { inherit lib stdenv ruby; };
    "6.1.1" = import ./6.1.1 { inherit lib stdenv ruby; };
    "7.0.1" = import ./7.0.1 { inherit lib stdenv ruby; };
    "8.0.0" = import ./8.0.0 { inherit lib stdenv ruby; };
    "8.0.1" = import ./8.0.1 { inherit lib stdenv ruby; };
    "8.0.2" = import ./8.0.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rspec-rails: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rspec-rails: unknown version '${version}'")
