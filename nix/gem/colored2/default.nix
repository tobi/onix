#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# colored2
#
# Versions: 3.1.2, 4.0.0, 4.0.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.0.3",
  git ? { },
}:
let
  versions = {
    "3.1.2" = import ./3.1.2 { inherit lib stdenv ruby; };
    "4.0.0" = import ./4.0.0 { inherit lib stdenv ruby; };
    "4.0.3" = import ./4.0.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "colored2: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "colored2: unknown version '${version}'")
