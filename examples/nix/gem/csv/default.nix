#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# csv
#
# Versions: 3.3.0, 3.3.3, 3.3.4, 3.3.5
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.3.5",
  git ? { },
}:
let
  versions = {
    "3.3.0" = import ./3.3.0 { inherit lib stdenv ruby; };
    "3.3.3" = import ./3.3.3 { inherit lib stdenv ruby; };
    "3.3.4" = import ./3.3.4 { inherit lib stdenv ruby; };
    "3.3.5" = import ./3.3.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "csv: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "csv: unknown version '${version}'")
