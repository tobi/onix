#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# blazer
#
# Versions: 2.6.5
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.6.5",
  git ? { },
}:
let
  versions = {
    "2.6.5" = import ./2.6.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "blazer: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "blazer: unknown version '${version}'")
