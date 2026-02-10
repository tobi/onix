#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# serverengine
#
# Versions: 2.0.7
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.0.7",
  git ? { },
}:
let
  versions = {
    "2.0.7" = import ./2.0.7 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "serverengine: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "serverengine: unknown version '${version}'")
