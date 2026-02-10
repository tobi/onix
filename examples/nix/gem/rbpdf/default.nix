#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rbpdf
#
# Versions: 1.21.4
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.21.4",
  git ? { },
}:
let
  versions = {
    "1.21.4" = import ./1.21.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rbpdf: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rbpdf: unknown version '${version}'")
