#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# axiom-types
#
# Versions: 0.0.5, 0.1.0, 0.1.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.1.1",
  git ? { },
}:
let
  versions = {
    "0.0.5" = import ./0.0.5 { inherit lib stdenv ruby; };
    "0.1.0" = import ./0.1.0 { inherit lib stdenv ruby; };
    "0.1.1" = import ./0.1.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "axiom-types: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "axiom-types: unknown version '${version}'")
