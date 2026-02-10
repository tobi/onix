#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# json-ld
#
# Versions: 3.3.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.3.2",
  git ? { },
}:
let
  versions = {
    "3.3.2" = import ./3.3.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "json-ld: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "json-ld: unknown version '${version}'")
