#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# readline
#
# Versions: 0.0.4
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.0.4",
  git ? { },
}:
let
  versions = {
    "0.0.4" = import ./0.0.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "readline: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "readline: unknown version '${version}'")
