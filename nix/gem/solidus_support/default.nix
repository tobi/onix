#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# solidus_support
#
# Versions: 0.15.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.15.0",
  git ? { },
}:
let
  versions = {
    "0.15.0" = import ./0.15.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "solidus_support: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "solidus_support: unknown version '${version}'")
