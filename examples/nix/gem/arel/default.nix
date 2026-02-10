#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# arel
#
# Versions: 7.1.4, 8.0.0, 9.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "9.0.0",
  git ? { },
}:
let
  versions = {
    "7.1.4" = import ./7.1.4 { inherit lib stdenv ruby; };
    "8.0.0" = import ./8.0.0 { inherit lib stdenv ruby; };
    "9.0.0" = import ./9.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "arel: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "arel: unknown version '${version}'")
