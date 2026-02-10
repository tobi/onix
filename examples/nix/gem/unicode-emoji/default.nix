#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# unicode-emoji
#
# Versions: 4.0.4, 4.1.0, 4.2.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.2.0",
  git ? { },
}:
let
  versions = {
    "4.0.4" = import ./4.0.4 { inherit lib stdenv ruby; };
    "4.1.0" = import ./4.1.0 { inherit lib stdenv ruby; };
    "4.2.0" = import ./4.2.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "unicode-emoji: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "unicode-emoji: unknown version '${version}'")
