#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# wicked_pdf
#
# Versions: 2.8.0, 2.8.1, 2.8.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.8.2",
  git ? { },
}:
let
  versions = {
    "2.8.0" = import ./2.8.0 { inherit lib stdenv ruby; };
    "2.8.1" = import ./2.8.1 { inherit lib stdenv ruby; };
    "2.8.2" = import ./2.8.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "wicked_pdf: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "wicked_pdf: unknown version '${version}'")
