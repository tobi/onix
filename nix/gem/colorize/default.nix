#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# colorize
#
# Versions: 1.0.3, 1.0.5, 1.1.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.1.0",
  git ? { },
}:
let
  versions = {
    "1.0.3" = import ./1.0.3 { inherit lib stdenv ruby; };
    "1.0.5" = import ./1.0.5 { inherit lib stdenv ruby; };
    "1.1.0" = import ./1.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "colorize: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "colorize: unknown version '${version}'")
