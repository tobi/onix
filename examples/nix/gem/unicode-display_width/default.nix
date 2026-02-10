#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# unicode-display_width
#
# Versions: 2.5.0, 3.1.4, 3.1.5, 3.2.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.2.0",
  git ? { },
}:
let
  versions = {
    "2.5.0" = import ./2.5.0 { inherit lib stdenv ruby; };
    "3.1.4" = import ./3.1.4 { inherit lib stdenv ruby; };
    "3.1.5" = import ./3.1.5 { inherit lib stdenv ruby; };
    "3.2.0" = import ./3.2.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "unicode-display_width: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "unicode-display_width: unknown version '${version}'")
