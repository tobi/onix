#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# stringio
#
# Versions: 3.1.0, 3.1.7, 3.1.8, 3.1.9, 3.2.0
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
    "3.1.0" = import ./3.1.0 { inherit lib stdenv ruby; };
    "3.1.7" = import ./3.1.7 { inherit lib stdenv ruby; };
    "3.1.8" = import ./3.1.8 { inherit lib stdenv ruby; };
    "3.1.9" = import ./3.1.9 { inherit lib stdenv ruby; };
    "3.2.0" = import ./3.2.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "stringio: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "stringio: unknown version '${version}'")
