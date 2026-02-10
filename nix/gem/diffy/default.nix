#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# diffy
#
# Versions: 3.4.2, 3.4.3, 3.4.4
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.4.4",
  git ? { },
}:
let
  versions = {
    "3.4.2" = import ./3.4.2 { inherit lib stdenv ruby; };
    "3.4.3" = import ./3.4.3 { inherit lib stdenv ruby; };
    "3.4.4" = import ./3.4.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "diffy: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "diffy: unknown version '${version}'")
