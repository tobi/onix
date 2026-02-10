#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# erb
#
# Versions: 5.1.1, 5.1.3, 6.0.0, 6.0.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.0.1",
  git ? { },
}:
let
  versions = {
    "5.1.1" = import ./5.1.1 { inherit lib stdenv ruby; };
    "5.1.3" = import ./5.1.3 { inherit lib stdenv ruby; };
    "6.0.0" = import ./6.0.0 { inherit lib stdenv ruby; };
    "6.0.1" = import ./6.0.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "erb: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "erb: unknown version '${version}'")
