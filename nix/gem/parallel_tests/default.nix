#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# parallel_tests
#
# Versions: 5.4.0, 5.5.0, 5.6.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.6.0",
  git ? { },
}:
let
  versions = {
    "5.4.0" = import ./5.4.0 { inherit lib stdenv ruby; };
    "5.5.0" = import ./5.5.0 { inherit lib stdenv ruby; };
    "5.6.0" = import ./5.6.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "parallel_tests: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "parallel_tests: unknown version '${version}'")
