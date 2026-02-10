#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# minitest
#
# Versions: 5.25.4, 5.25.5, 5.26.2, 5.27.0, 6.0.0, 6.0.1
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
    "5.25.4" = import ./5.25.4 { inherit lib stdenv ruby; };
    "5.25.5" = import ./5.25.5 { inherit lib stdenv ruby; };
    "5.26.2" = import ./5.26.2 { inherit lib stdenv ruby; };
    "5.27.0" = import ./5.27.0 { inherit lib stdenv ruby; };
    "6.0.0" = import ./6.0.0 { inherit lib stdenv ruby; };
    "6.0.1" = import ./6.0.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "minitest: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "minitest: unknown version '${version}'")
