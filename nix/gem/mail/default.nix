#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mail
#
# Versions: 2.8.0.1, 2.8.1, 2.9.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.9.0",
  git ? { },
}:
let
  versions = {
    "2.8.0.1" = import ./2.8.0.1 { inherit lib stdenv ruby; };
    "2.8.1" = import ./2.8.1 { inherit lib stdenv ruby; };
    "2.9.0" = import ./2.9.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mail: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "mail: unknown version '${version}'")
