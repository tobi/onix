#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# minitest-reporters
#
# Versions: 1.6.1, 1.7.0, 1.7.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.7.1",
  git ? { },
}:
let
  versions = {
    "1.6.1" = import ./1.6.1 { inherit lib stdenv ruby; };
    "1.7.0" = import ./1.7.0 { inherit lib stdenv ruby; };
    "1.7.1" = import ./1.7.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "minitest-reporters: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "minitest-reporters: unknown version '${version}'")
