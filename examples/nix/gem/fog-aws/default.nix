#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fog-aws
#
# Versions: 3.21.0, 3.32.0, 3.33.0, 3.33.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.33.1",
  git ? { },
}:
let
  versions = {
    "3.21.0" = import ./3.21.0 { inherit lib stdenv ruby; };
    "3.32.0" = import ./3.32.0 { inherit lib stdenv ruby; };
    "3.33.0" = import ./3.33.0 { inherit lib stdenv ruby; };
    "3.33.1" = import ./3.33.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "fog-aws: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "fog-aws: unknown version '${version}'")
