#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# crack
#
# Versions: 0.4.6, 1.0.0, 1.0.1
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
    "0.4.6" = import ./0.4.6 { inherit lib stdenv ruby; };
    "1.0.0" = import ./1.0.0 { inherit lib stdenv ruby; };
    "1.0.1" = import ./1.0.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "crack: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "crack: unknown version '${version}'")
