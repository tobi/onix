#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# xcpretty-travis-formatter
#
# Versions: 0.0.4, 1.0.0, 1.0.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.1",
  git ? { },
}:
let
  versions = {
    "0.0.4" = import ./0.0.4 { inherit lib stdenv ruby; };
    "1.0.0" = import ./1.0.0 { inherit lib stdenv ruby; };
    "1.0.1" = import ./1.0.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "xcpretty-travis-formatter: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "xcpretty-travis-formatter: unknown version '${version}'")
