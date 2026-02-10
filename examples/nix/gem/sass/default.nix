#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sass
#
# Versions: 3.7.2, 3.7.3, 3.7.4
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.7.4",
  git ? { },
}:
let
  versions = {
    "3.7.2" = import ./3.7.2 { inherit lib stdenv ruby; };
    "3.7.3" = import ./3.7.3 { inherit lib stdenv ruby; };
    "3.7.4" = import ./3.7.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sass: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "sass: unknown version '${version}'")
