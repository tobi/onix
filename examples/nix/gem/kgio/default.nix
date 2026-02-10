#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# kgio
#
# Versions: 2.11.2, 2.11.3, 2.11.4
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.11.4",
  git ? { },
}:
let
  versions = {
    "2.11.2" = import ./2.11.2 { inherit lib stdenv ruby; };
    "2.11.3" = import ./2.11.3 { inherit lib stdenv ruby; };
    "2.11.4" = import ./2.11.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "kgio: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "kgio: unknown version '${version}'")
