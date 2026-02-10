#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# require_all
#
# Versions: 1.5.0, 2.0.0, 3.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.0.0",
  git ? { },
}:
let
  versions = {
    "1.5.0" = import ./1.5.0 { inherit lib stdenv ruby; };
    "2.0.0" = import ./2.0.0 { inherit lib stdenv ruby; };
    "3.0.0" = import ./3.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "require_all: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "require_all: unknown version '${version}'")
