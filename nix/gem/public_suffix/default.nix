#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# public_suffix
#
# Versions: 6.0.1, 6.0.2, 7.0.0, 7.0.1, 7.0.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "7.0.2",
  git ? { },
}:
let
  versions = {
    "6.0.1" = import ./6.0.1 { inherit lib stdenv ruby; };
    "6.0.2" = import ./6.0.2 { inherit lib stdenv ruby; };
    "7.0.0" = import ./7.0.0 { inherit lib stdenv ruby; };
    "7.0.1" = import ./7.0.1 { inherit lib stdenv ruby; };
    "7.0.2" = import ./7.0.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "public_suffix: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "public_suffix: unknown version '${version}'")
