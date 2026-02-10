#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sigdump
#
# Versions: 0.2.3, 0.2.4, 0.2.5
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.2.5",
  git ? { },
}:
let
  versions = {
    "0.2.3" = import ./0.2.3 { inherit lib stdenv ruby; };
    "0.2.4" = import ./0.2.4 { inherit lib stdenv ruby; };
    "0.2.5" = import ./0.2.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sigdump: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "sigdump: unknown version '${version}'")
