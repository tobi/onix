#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# paper_trail
#
# Versions: 15.2.0, 16.0.0, 17.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "17.0.0",
  git ? { },
}:
let
  versions = {
    "15.2.0" = import ./15.2.0 { inherit lib stdenv ruby; };
    "16.0.0" = import ./16.0.0 { inherit lib stdenv ruby; };
    "17.0.0" = import ./17.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "paper_trail: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "paper_trail: unknown version '${version}'")
