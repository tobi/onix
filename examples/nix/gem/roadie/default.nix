#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# roadie
#
# Versions: 5.2.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.2.1",
  git ? { },
}:
let
  versions = {
    "5.2.1" = import ./5.2.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "roadie: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "roadie: unknown version '${version}'")
