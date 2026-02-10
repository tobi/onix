#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# eventmachine
#
# Versions: 1.2.5, 1.2.6, 1.2.7
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.7",
  git ? { },
}:
let
  versions = {
    "1.2.5" = import ./1.2.5 { inherit lib stdenv ruby; };
    "1.2.6" = import ./1.2.6 { inherit lib stdenv ruby; };
    "1.2.7" = import ./1.2.7 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "eventmachine: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "eventmachine: unknown version '${version}'")
