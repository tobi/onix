#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# minitest-mock
#
# Versions: 5.27.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.27.0",
  git ? { },
}:
let
  versions = {
    "5.27.0" = import ./5.27.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "minitest-mock: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "minitest-mock: unknown version '${version}'")
