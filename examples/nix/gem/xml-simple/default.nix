#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# xml-simple
#
# Versions: 1.1.7, 1.1.8, 1.1.9
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.1.9",
  git ? { },
}:
let
  versions = {
    "1.1.7" = import ./1.1.7 { inherit lib stdenv ruby; };
    "1.1.8" = import ./1.1.8 { inherit lib stdenv ruby; };
    "1.1.9" = import ./1.1.9 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "xml-simple: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "xml-simple: unknown version '${version}'")
