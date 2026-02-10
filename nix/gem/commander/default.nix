#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# commander
#
# Versions: 4.5.2, 4.6.0, 5.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.0.0",
  git ? { },
}:
let
  versions = {
    "4.5.2" = import ./4.5.2 { inherit lib stdenv ruby; };
    "4.6.0" = import ./4.6.0 { inherit lib stdenv ruby; };
    "5.0.0" = import ./5.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "commander: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "commander: unknown version '${version}'")
