#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rspec_junit_formatter
#
# Versions: 0.5.0, 0.5.1, 0.6.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.6.0",
  git ? { },
}:
let
  versions = {
    "0.5.0" = import ./0.5.0 { inherit lib stdenv ruby; };
    "0.5.1" = import ./0.5.1 { inherit lib stdenv ruby; };
    "0.6.0" = import ./0.6.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rspec_junit_formatter: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rspec_junit_formatter: unknown version '${version}'")
