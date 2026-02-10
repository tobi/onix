#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# gyoku
#
# Versions: 1.3.0, 1.3.1, 1.4.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.4.0",
  git ? { },
}:
let
  versions = {
    "1.3.0" = import ./1.3.0 { inherit lib stdenv ruby; };
    "1.3.1" = import ./1.3.1 { inherit lib stdenv ruby; };
    "1.4.0" = import ./1.4.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "gyoku: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "gyoku: unknown version '${version}'")
