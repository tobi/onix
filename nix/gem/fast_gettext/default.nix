#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fast_gettext
#
# Versions: 4.0.0, 4.1.0, 4.1.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.1.1",
  git ? { },
}:
let
  versions = {
    "4.0.0" = import ./4.0.0 { inherit lib stdenv ruby; };
    "4.1.0" = import ./4.1.0 { inherit lib stdenv ruby; };
    "4.1.1" = import ./4.1.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "fast_gettext: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "fast_gettext: unknown version '${version}'")
