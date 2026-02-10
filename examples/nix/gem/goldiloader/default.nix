#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# goldiloader
#
# Versions: 6.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.0.0",
  git ? { },
}:
let
  versions = {
    "6.0.0" = import ./6.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "goldiloader: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "goldiloader: unknown version '${version}'")
