#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# recursive-open-struct
#
# Versions: 1.3.1, 2.0.0, 2.1.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.1.0",
  git ? { },
}:
let
  versions = {
    "1.3.1" = import ./1.3.1 { inherit lib stdenv ruby; };
    "2.0.0" = import ./2.0.0 { inherit lib stdenv ruby; };
    "2.1.0" = import ./2.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "recursive-open-struct: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "recursive-open-struct: unknown version '${version}'")
