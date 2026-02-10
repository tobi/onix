#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# unicorn
#
# Versions: 5.8.0, 6.0.0, 6.1.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.1.0",
  git ? { },
}:
let
  versions = {
    "5.8.0" = import ./5.8.0 { inherit lib stdenv ruby; };
    "6.0.0" = import ./6.0.0 { inherit lib stdenv ruby; };
    "6.1.0" = import ./6.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "unicorn: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "unicorn: unknown version '${version}'")
