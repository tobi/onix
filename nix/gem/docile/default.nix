#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# docile
#
# Versions: 1.3.5, 1.4.0, 1.4.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.4.1",
  git ? { },
}:
let
  versions = {
    "1.3.5" = import ./1.3.5 { inherit lib stdenv ruby; };
    "1.4.0" = import ./1.4.0 { inherit lib stdenv ruby; };
    "1.4.1" = import ./1.4.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "docile: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "docile: unknown version '${version}'")
