#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fog-core
#
# Versions: 2.3.0, 2.4.0, 2.5.0, 2.6.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.6.0",
  git ? { },
}:
let
  versions = {
    "2.3.0" = import ./2.3.0 { inherit lib stdenv ruby; };
    "2.4.0" = import ./2.4.0 { inherit lib stdenv ruby; };
    "2.5.0" = import ./2.5.0 { inherit lib stdenv ruby; };
    "2.6.0" = import ./2.6.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "fog-core: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "fog-core: unknown version '${version}'")
