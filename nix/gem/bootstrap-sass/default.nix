#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# bootstrap-sass
#
# Versions: 3.3.7, 3.4.0, 3.4.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.4.1",
  git ? { },
}:
let
  versions = {
    "3.3.7" = import ./3.3.7 { inherit lib stdenv ruby; };
    "3.4.0" = import ./3.4.0 { inherit lib stdenv ruby; };
    "3.4.1" = import ./3.4.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "bootstrap-sass: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "bootstrap-sass: unknown version '${version}'")
