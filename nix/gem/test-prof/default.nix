#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# test-prof
#
# Versions: 1.2.1, 1.3.3, 1.5.0, 1.5.1, 1.5.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.5.2",
  git ? { },
}:
let
  versions = {
    "1.2.1" = import ./1.2.1 { inherit lib stdenv ruby; };
    "1.3.3" = import ./1.3.3 { inherit lib stdenv ruby; };
    "1.5.0" = import ./1.5.0 { inherit lib stdenv ruby; };
    "1.5.1" = import ./1.5.1 { inherit lib stdenv ruby; };
    "1.5.2" = import ./1.5.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "test-prof: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "test-prof: unknown version '${version}'")
