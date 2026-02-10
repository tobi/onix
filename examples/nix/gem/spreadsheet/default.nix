#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# spreadsheet
#
# Versions: 1.3.2, 1.3.3, 1.3.4
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.3.4",
  git ? { },
}:
let
  versions = {
    "1.3.2" = import ./1.3.2 { inherit lib stdenv ruby; };
    "1.3.3" = import ./1.3.3 { inherit lib stdenv ruby; };
    "1.3.4" = import ./1.3.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "spreadsheet: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "spreadsheet: unknown version '${version}'")
