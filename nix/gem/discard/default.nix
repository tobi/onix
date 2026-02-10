#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# discard
#
# Versions: 1.4.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.4.0",
  git ? { },
}:
let
  versions = {
    "1.4.0" = import ./1.4.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "discard: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "discard: unknown version '${version}'")
