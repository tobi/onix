#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rbpdf-font
#
# Versions: 1.19.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.19.1",
  git ? { },
}:
let
  versions = {
    "1.19.1" = import ./1.19.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rbpdf-font: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rbpdf-font: unknown version '${version}'")
