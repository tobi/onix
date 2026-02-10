#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# has_scope
#
# Versions: 0.8.1, 0.8.2, 0.9.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.9.0",
  git ? { },
}:
let
  versions = {
    "0.8.1" = import ./0.8.1 { inherit lib stdenv ruby; };
    "0.8.2" = import ./0.8.2 { inherit lib stdenv ruby; };
    "0.9.0" = import ./0.9.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "has_scope: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "has_scope: unknown version '${version}'")
