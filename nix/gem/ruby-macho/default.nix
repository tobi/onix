#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby-macho
#
# Versions: 4.0.1, 4.1.0, 5.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.0.0",
  git ? { },
}:
let
  versions = {
    "4.0.1" = import ./4.0.1 { inherit lib stdenv ruby; };
    "4.1.0" = import ./4.1.0 { inherit lib stdenv ruby; };
    "5.0.0" = import ./5.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ruby-macho: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "ruby-macho: unknown version '${version}'")
