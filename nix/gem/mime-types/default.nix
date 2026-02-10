#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mime-types
#
# Versions: 3.4.1, 3.5.2, 3.6.1, 3.6.2, 3.7.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.7.0",
  git ? { },
}:
let
  versions = {
    "3.4.1" = import ./3.4.1 { inherit lib stdenv ruby; };
    "3.5.2" = import ./3.5.2 { inherit lib stdenv ruby; };
    "3.6.1" = import ./3.6.1 { inherit lib stdenv ruby; };
    "3.6.2" = import ./3.6.2 { inherit lib stdenv ruby; };
    "3.7.0" = import ./3.7.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mime-types: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "mime-types: unknown version '${version}'")
